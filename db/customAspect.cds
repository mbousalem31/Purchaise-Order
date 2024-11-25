namespace india.customAspect;


type Gender: String(1)  enum {
    male= 'M';
    female= 'F';
    other='O';
    noDisclosure='N'   
}

// assert.format is used for validation. Checiking phoneNumber and email patterns.

type phoneNumber : String(30)@assert.format : '([+])?((\d)[.-]?)?[\s]?\(?(\d{3})\)?[.-]?[\s]?(\d{3})[.-]?[\s]?(\d{4,})';
type Email: String(255) @assert.format : '^[a-zA-Z0-9_.±]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$';

// Aspect for amount fields

type AmountType : Decimal(15,2);
aspect Amount {
        CURRENCY_CODE: String(4);
        GROSS_AMOUNT: AmountType;
        NET_AMOUNT:AmountType;
        TAX_AMOUNT: AmountType;
}
