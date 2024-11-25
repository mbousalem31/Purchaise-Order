const { insert } = require('@sap/cds');
const cds = require('@sap/cds');
const { worker } = cds.entities("india.db.master");

const NewCQLService = function (srv) {
    //read data from worker table
    srv.on("READ", "readWorker", async (req, res) => {
        var results = [];
        results = await cds.tx(req).run(SELECT.from(worker).where({ "firstName": "Saurabh" }))
        return results;
    })

    // Inserting data in table whenever is passing in payload  
    srv.on("CREATE", "insertWorker", async (req, res) => {
        //when you need DML data manual operation you should work with transaction
        let returnData = await cds.transaction(req).run([
            INSERT.into(worker).entries([req.data])
            // req.data is the data payload coming in the request, which contains the information that needs to be inserted into the worker table (e.g., name, age, etc.).
            // entities[req.data] to informe the kind of data and respect required format of the fields of entity
        ]).then((resolve, reject) => {
            if (typeof (resolve) !== undefined) {
                return req.data;
            } else return req.error(500, "there was an error!")
        }).catch(err => {
            req.error(500, "Below error occured" + err.toString());
        })
        return returnData
    })

    // Update table records
    srv.on("UPDATE", "updateWorker", async (req, res) => {
        let returnData = await cds.transaction(req).run([
            UPDATE(worker).set({
                firstName: req.data.firstName
            }).where({ ID: req.data.ID }),
            UPDATE(worker).set({
                lastName: req.data.lastName
            }).where({ ID: req.data.ID }),
        ]).then((resolve, reject) => {
            if (typeof (resolve) !== undefined) {
                return req.data;
            } else return req.error(500, "there was an error!")
        }).catch(err => {
            req.error(500, "Below error occured" + err.toString());
        })
        return returnData
    })

    // Delete Operation

    srv.on("DELETE", "deleteWorker",  async(req,res)=>{
        let returnData= await cds.transaction(req).run([
            DELETE.from(worker).where(req.data)
        ]).then((resolve, reject) => {
            if (typeof (resolve) !== undefined) {
                return req.data;
            } else return req.error(500, "there was an error!")
        }).catch(err => {
            req.error(500, "Below error occured" + err.toString());
        })
        return returnData
    })
}

module.exports = NewCQLService