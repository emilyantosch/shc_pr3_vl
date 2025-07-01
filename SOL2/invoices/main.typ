#import "@preview/classy-german-invoice:0.3.1": invoice

#show: invoice(
  // Invoice number
  "2024-001",
  // Invoice date
  datetime(year: 2024, month: 12, day: 16),
  // Items
  (
    (
      description: "Unterricht am SHC (HAW) im Fach 'Objektorientierte Programmierung in der Automationstechnik'",
      price: 2640.00,
    ),
  ),
  // Author
  (
    name: "Emily Lucia Antosch",
    street: "Krausestr. 4",
    zip: "22305",
    city: "Hamburg",
    tax_nr: "43/007/05060",
  ),
  // Recipient
  (
    name: "HAW Hamburg",
    street: "Berliner Tor 5",
    zip: "20099",
    city: "Hamburg",
  ),
  // Bank account
  (
    name: "Emily Lucia Antosch",
    bank: "Sparkasse Westholstein",
    iban: "DE55 2225 0020 0090 3352 90",
    bic: "NOLADE21WHO",
    // There is currently only one gendered term in this template.
    // You can overwrite it, or omit it and just choose the default.
    gender: (account_holder: "Kontoinhaberin"),
  ),
  // Umsatzsteuersatz (VAT)
  vat: 0.19,
  kleinunternehmer: true,
)

