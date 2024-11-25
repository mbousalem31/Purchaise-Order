const axios = require('axios');
const cds = require('@sap/cds');
module.exports = cds.service.impl(async function () {
    //const { ExternalData } = this.entities;
    this.on('READ', "externalApi", async (req) => {
        try {
            
            const response = await axios.get('https://jsonplaceholder.typicode.com/posts')
            return response.data
        } catch (error) {
            req.error(500, 'Failed to Fetch external data from the API')
        }
    })
})