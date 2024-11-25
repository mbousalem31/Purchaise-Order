namespace india.db;

using {
    india.db.master,
    india.db.transaction
} from './datamodel';

context CDSViews {
    define view ![PODetails] as
        select from transaction.purchaseorder {
            key PO_ID                                 as ![PurchaseOrders],
                PARTNER_GUID.BP_ID                    as ![VendorId],
                PARTNER_GUID.COMPANY_NAME             as ![CompanyName],
                PARTNER_GUID.ADDRESS_GUID.COUNTRY     as ![Country],
                PARTNER_GUID.ADDRESS_GUID.CITY        as ![CITY],
                PARTNER_GUID.ADDRESS_GUID.STREET      as ![STREET],
                PARTNER_GUID.ADDRESS_GUID.POSTAL_CODE as ![CodePostal],
                GROSS_AMOUNT                          as ![PoGrossAmount],
                CURRENCY_CODE                         as ![PoCurrencyCode],
            key Items.PO_ITEM_POS                     as ![POItemsPosition],
                Items.PRODUCT_GUID.PRODUCT_ID         as ![PoductId],
                Items.PRODUCT_GUID.DESCRIPTION        as ![DescriptionProduct],
                Items.GROSS_AMOUNT                    as ![ItemGrossAmount],
                Items.NET_AMOUNT                      as ![ItemsNETamount]
        }

    //another view

    define view ![ItemView] as
        select from transaction.poitems {
            key PARENT_KEY.PARTNER_GUID.NODE_KEY as ![VendorId],
                PRODUCT_GUID.PRODUCT_ID          as ![ProductId],
                PRODUCT_GUID.DESCRIPTION         as ![DescriptionProduct],
                GROSS_AMOUNT                     as ![TotalAmount],
                CURRENCY_CODE                    as ![Currency],
                PARENT_KEY.OVERALL_STATUS        as ![PoStatus],
        }

    //using Aggregation

    define view ProductSum as
        select from master.product as prod {
            key PRODUCT_ID        as ![ProductId],
                texts.DESCRIPTION as ![Description],
                (
                    select from transaction.poitems as a {
                        SUM(
                            a.GROSS_AMOUNT
                        ) as SUM
                    }
                    where
                        a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
                )                 as PO_SUM : Decimal(10, 2)


        }

}
