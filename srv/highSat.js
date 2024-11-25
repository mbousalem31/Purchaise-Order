const cds = require('@sap/cds');

module.exports= srv => {
    srv.on('getHightSalary',async req =>{
        try {
            const {worker}= cds.entities('india.db.master');
            const highestSalaryWorker = await cds.run(SELECT.one `salaryAmount as highestSalary, firstName, lastName`
            .from(worker)
            .orderBy `salaryAmount DESC`);

            if (highestSalaryWorker.highestSalary){
                return highestSalaryWorker
            } else return null;
        } catch (error) {
            req.error(500, 'Error fetching highest Salary :', error.message );
            return null;
        }
        
        
        
       
    })
}