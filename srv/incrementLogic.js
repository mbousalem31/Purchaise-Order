module.exports = cds.service.impl(async function (){
    const { worker } = this.entities("india.db.master");
   

    this.on('hike', async req => {
        const { ID } = req.data;
        if (!ID) {
            return req.reject(400, 'ID is required');
        }
        console.log(`Received request to increment salary for worker with ID: ${ID}`);
        const tx = cds.transaction(req);
        try {
            //retreive the current salary amount of the worker
            const updatedworker = await tx.read(worker).where({ ID: ID });

            if (!updatedworker || updatedworker.length === 0) {
                await tx.rollback();
                return req.reject(404, `worker with ID ${ID} not found`);
            }
            const currentSalary = updatedworker[0].salaryAmount;
            console.log(`Current salary of worker with ID ${ID} is ${currentSalary}`);
            // update operation to increment salary by 2000
            const result = await tx.update(worker)
                .set({ salaryAmount: currentSalary + 2000 })
                .where({ ID: ID })

            if (result === 0) {
                await tx.rollback();
                return req.reject(500, `Failed to retreive updated worker `)
            }

            //Commit the transaction
            await tx.commit()
            console.log(`Update worker with ID ${ID} retrieved successfully`);
            return req.reply({ message: "Incremented", worker: updatedworker[0] })
        } catch (error) {
            //Rollback the transaction in case of an error
            console.error("Error during hike action:", error);
            try {
                await tx.rollback();
            } catch (rollbackError) {
                console.error("Rollback is failed:", rollbackError);
            }
            return req.reject(500, `Error :${error.message}`);
        }

    })
});