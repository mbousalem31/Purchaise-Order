using {india.db.master} from '../db/datamodel';
service myIncrement {
    entity worker as projection on master.worker;
    action hike(ID:UUID);                

}