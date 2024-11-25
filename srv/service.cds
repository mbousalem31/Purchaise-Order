using {
    india.db.master,
    india.db.transaction
} from '../db/datamodel';


service CatalogService @(path: 'CatalogService') @(requires : 'authenticated-user'){
  
    entity businesspartner as projection on master.businesspartner;

    annotate CatalogService.businesspartner with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity address         as projection on master.address;

    annotate CatalogService.address with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity purchaseorder   as projection on transaction.purchaseorder;

    annotate CatalogService.purchaseorder with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity poitems         as projection on transaction.poitems;

    annotate CatalogService.poitems with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });

    entity product         as projection on master.product;

    annotate CatalogService.product with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false}
    });


    entity worker @(restrict :[
        {grant : ['READ'],
        to: 'Viewer',
        where: 'Gender = $user.Gender'
        },
        {grant : ['READ','WRITE'],
        to: 'Admin',
        }
    ])
             as projection on master.worker


// Function implentation hightSat.js

}

@impl: './highSat.js'
service highsal {
    entity workers as projection on master.worker;
    function getHightSalary() returns Decimal(15,2);

}
