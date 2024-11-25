using { Fr.db.ExternalData} from '../db/externalApiDatamodel';

service ExternaApiService {

   entity externalApi as projection on ExternalData;

}