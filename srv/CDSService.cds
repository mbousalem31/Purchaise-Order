using {india.db.CDSViews} from '../db/CDSViews';

service CDSViewsService @(path: 'CDSViewsService') {
    entity PODetails as projection on CDSViews.PODetails;
    entity ItemView    as projection on CDSViews.ItemView;
    entity ProductSum  as projection on CDSViews.ProductSum;
}