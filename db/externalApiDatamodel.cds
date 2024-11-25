namespace Fr.db;

entity ExternalData {
    key userId : Integer;
    id   : Integer;
    title : String(50);
    body: String(100)
}