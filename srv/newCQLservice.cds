using {india.db.master}   from '../db/datamodel';


service NewCQLService @(path:'NewCQLService'){
    @readonly
    entity readWorker as projection on master.worker;

    @insertonly
    entity insertWorker as projection on master.worker;

    @updateonly
    entity updateWorker as projection on master.worker;

    @deleteonly
    entity deleteWorker as projection on master.worker;
}