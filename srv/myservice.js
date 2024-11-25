const mysrv=function(srv){
    srv.on('myFunc', (req,res)=>{
        return "Welcome"+req.data.msg
    })
}
module.exports=mysrv