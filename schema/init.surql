

#cash
let $cash = create gl_account content {
    name: "Cash",
    type: "asset",
};

# banks

let $banks_gl_acc = create gl_account content {
    name: "Banks",
    type: "asset",
};



# receivable
let $receivable = create gl_account content {
    name: "Receivale",
    type: "asset",
};


#======liabilities

#payables
let $payable = create gl_account content {
    name: "Payable",
    type: "liability",
};

let $loan = create gl_account content {
    name: "Loan",
    type: "liability",
};


# expense

let $expense = create gl_account content {
    name: "Expenses",
    type: "expense",
    meta: {type: "custom"},
};

#equity Accounts
let $owner_capital = create gl_account content {
    name: "OwnerCapital",
    type: "equity",
};

let $owner_draw = create gl_account content {
    name: "OwnerDraw",
    type: "equity"
};

let $retain_earnings = create gl_account content {
    name: "RetainEarning",
    type: "equity",
};


let $sales_discount = create gl_account content {
    name: "SalesDiscount",
    type: "contra_income",
};


let $sales_discount = create gl_account content {
    name: "PurchaseDiscount",
    type: "contra_expense",
};


for $cat in [
    {
        name: "tickets",
        description: "tracks tickets"
    },
    {
        name: "svp",
        description: "tracks saudi visa processes"
    },
    {
        name: "general",
        description: "tracks general tasks"
    },
] {

    create only task_category content{
        name: $cat.name,
        description: $cat.description
    };
    
};




fn::add_pipeline_template(
    "svp labour", 
    [
        {
            name: "medical",
            description: "medical",
            index: 0,
            tasks: [{name: "examination", "description": "whether medical examination has been done"}], 
        },
        {
            name: "labour test",
            description: "skill test",
            index: 1,
            tasks: [{name: "test", "description": "whether skill test has been passed"}], 
        },
        {
            name: "documents collection",
            description: "medical",
            index: 2,
            tasks: [
                {name: "frc", description: "has FRC been provided"}, 
                {name: "police clearance", description: "Has Police Clearance created"},
                 {name: "pictures", description: "pictures provided"}], 
        },
         {
            name: "sent to embassy",
            description: "in embassy",
            index: 3,
            tasks: [{name: "visa issued", description: "is visa issued"}], 
        },
         {
            name: "protector",
            description: "protector",
            index: 4,
            tasks: [
                {name: "docs received", description: "Are the documents received back from the embassy"}, 
                {name: "biometric", description: "Has the immigrant done biometrics"}, 
                {name: "protector done", description: "Is passport cleared from protectorate office"}
                ], 
        },
    ],
);

let $airports = [
    {
        "airport_name": "A Coruna",
        "airport_code": "LCG",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "A Coruna Airport",
        "latitude": "43.366667",
        "longitude": "-8.383333"
    },
    {
        "airport_name": "Aalborg",
        "airport_code": "AAL",
        "country_name": "Denmark",
        "country_code": "DK",
        "country_long_code": "DNK",
        "airport_description": "Aalborg Airport",
        "latitude": "57.0928",
        "longitude": "9.8492"
    },
    {
        "airport_name": "Aarhus",
        "airport_code": "AAR",
        "country_name": "Denmark",
        "country_code": "DK",
        "country_long_code": "DNK",
        "airport_description": "Aarhus Airport",
        "latitude": "56.3",
        "longitude": "10.619"
    },
    {
        "airport_name": "Aberdeen",
        "airport_code": "ABZ",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Dyce",
        "latitude": "57.2",
        "longitude": "-2.2"
    },
    {
        "airport_name": "Aberdeen",
        "airport_code": "ABR",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Aberdeen Regional Airport",
        "latitude": "45.4491",
        "longitude": "-98.4218"
    },
    {
        "airport_name": "Abha",
        "airport_code": "AHB",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Abha",
        "latitude": "18.216667",
        "longitude": "42.5"
    },
    {
        "airport_name": "Abidjan",
        "airport_code": "ABJ",
        "country_name": "Cote d'Ivoire",
        "country_code": "CI",
        "country_long_code": "CIV",
        "airport_description": "Felix Houphouet Boigny International Airport ",
        "latitude": "5.25",
        "longitude": "-3.933333"
    },
    {
        "airport_name": "Abu Dhabi",
        "airport_code": "AUH",
        "country_name": "United Arab Emirates",
        "country_code": "AE",
        "country_long_code": "ARE",
        "airport_description": "Abu Dhabi Airport",
        "latitude": "24.433056",
        "longitude": "54.651111"
    },
    {
        "airport_name": "Abuja",
        "airport_code": "ABV",
        "country_name": "Nigeria",
        "country_code": "NG",
        "country_long_code": "NGA",
        "airport_description": "Nnamdi Azikiwe International",
        "latitude": "9.006667",
        "longitude": "7.263056"
    },
    {
        "airport_name": "Acapulco",
        "airport_code": "ACA",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Juan N. \u00c1lvarez International Airport",
        "latitude": "16.7571",
        "longitude": "-99.7536"
    },
    {
        "airport_name": "Accra",
        "airport_code": "ACC",
        "country_name": "Ghana",
        "country_code": "GH",
        "country_long_code": "GHA",
        "airport_description": "Kotoka International",
        "latitude": "5.6",
        "longitude": "-0.166667"
    },
    {
        "airport_name": "Adana",
        "airport_code": "ADA",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Sakirpasa",
        "latitude": "36.982222",
        "longitude": "35.280278"
    },
    {
        "airport_name": "Addis Ababa",
        "airport_code": "ADD",
        "country_name": "Ethiopia",
        "country_code": "ET",
        "country_long_code": "ETH",
        "airport_description": "Bole International",
        "latitude": "8.977778",
        "longitude": "38.799444"
    },
    {
        "airport_name": "Adelaide",
        "airport_code": "ADL",
        "country_name": "Australia",
        "country_code": "AU",
        "country_long_code": "AUS",
        "airport_description": "International",
        "latitude": "-34.945",
        "longitude": "138.530556"
    },
    {
        "airport_name": "Adiyaman",
        "airport_code": "ADF",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Adiyaman Airport",
        "latitude": "37.7314",
        "longitude": "38.4689"
    },
    {
        "airport_name": "Agadir",
        "airport_code": "AGA",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Al Massira",
        "latitude": "30.383333",
        "longitude": "-9.55"
    },
    {
        "airport_name": "Agartala",
        "airport_code": "IXA",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Maharaja Bir Bikram Airport",
        "latitude": "23.886",
        "longitude": "91.2404"
    },
    {
        "airport_name": "Agra",
        "airport_code": "AGR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Agra Airport",
        "latitude": "27.1558",
        "longitude": "77.9609"
    },
    {
        "airport_name": "Agri",
        "airport_code": "AJI",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "A\u011fr\u0131 Airport",
        "latitude": "39.6545",
        "longitude": "43.026"
    },
    {
        "airport_name": "Aguascalientes",
        "airport_code": "AGU",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Lic. Jes\u00fas Ter\u00e1n Peredo International Airport",
        "latitude": "21.7056",
        "longitude": "-102.3189"
    },
    {
        "airport_name": "Ahmedabad",
        "airport_code": "AMD",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "S.Vallabhbhai Patel",
        "latitude": "23.077222",
        "longitude": "72.634722"
    },
    {
        "airport_name": "Ajaccio",
        "airport_code": "AJA",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Napoleon Bonaparte",
        "latitude": "41.916667",
        "longitude": "8.8"
    },
    {
        "airport_name": "Aksu",
        "airport_code": "AKU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Aksu Airport",
        "latitude": "41.2625",
        "longitude": "80.2917"
    },
    {
        "airport_name": "Al Baha",
        "airport_code": "ABT",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Al-Aqiq",
        "latitude": "22.833333",
        "longitude": "42.216667"
    },
    {
        "airport_name": "Albany",
        "airport_code": "ABY",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Southwest Georgia Regional Airport",
        "latitude": "31.532",
        "longitude": "-84.1945"
    },
    {
        "airport_name": "\u00c5lesund",
        "airport_code": "AES",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "\u00c5lesund Airport, Vigra",
        "latitude": "62.5604",
        "longitude": "6.1102"
    },
    {
        "airport_name": "Alexandria",
        "airport_code": "HBE",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Alexandria International Airport",
        "latitude": "30.917778",
        "longitude": "29.696389"
    },
    {
        "airport_name": "Alexandria",
        "airport_code": "AEX",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Alexandria International Airport",
        "latitude": "31.3274",
        "longitude": "-92.5498"
    },
    {
        "airport_name": "Alexandroupolis",
        "airport_code": "AXD",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Alexandroupolis Dimokritos Airport",
        "latitude": "40.851111",
        "longitude": "25.951111"
    },
    {
        "airport_name": "Algiers",
        "airport_code": "ALG",
        "country_name": "Algeria",
        "country_code": "DZ",
        "country_long_code": "DZA",
        "airport_description": "Houari Boumediene",
        "latitude": "36.783333",
        "longitude": "3.05"
    },
    {
        "airport_name": "Alicante",
        "airport_code": "ALC",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Alicante Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Allentown",
        "airport_code": "ABE",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Lehigh Valley International Airport",
        "latitude": "40.6521",
        "longitude": "-75.4408"
    },
    {
        "airport_name": "Almaty",
        "airport_code": "ALA",
        "country_name": "Kazakhstan",
        "country_code": "KZ",
        "country_long_code": "KAZ",
        "airport_description": "Almaty International Airport",
        "latitude": "43.349927",
        "longitude": "77.025289"
    },
    {
        "airport_name": "Almeria",
        "airport_code": "LEI",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Almeria",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Alor setar",
        "airport_code": "AOR",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Sultan Abdul Halim Airport",
        "latitude": "6.189722",
        "longitude": "100.398056"
    },
    {
        "airport_name": "Alpena",
        "airport_code": "APN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Alpena County Regional Airport",
        "latitude": "45.0781",
        "longitude": "-83.5603"
    },
    {
        "airport_name": "Alta",
        "airport_code": "ALF",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Alta Airport",
        "latitude": "69.9761",
        "longitude": "23.3717"
    },
    {
        "airport_name": "Altay",
        "airport_code": "AAT",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Altay Airport",
        "latitude": "47.7507",
        "longitude": "88.0844"
    },
    {
        "airport_name": "AlUla",
        "airport_code": "ULH",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "AlUla International Airport",
        "latitude": "26.4779423",
        "longitude": "38.1143626"
    },
    {
        "airport_name": "Amasya",
        "airport_code": "MZH",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Merzifon",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Ambon",
        "airport_code": "AMQ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Pattimura Airport",
        "latitude": "-3.7103",
        "longitude": "128.0892"
    },
    {
        "airport_name": "Amman",
        "airport_code": "AMM",
        "country_name": "Jordan",
        "country_code": "JO",
        "country_long_code": "JOR",
        "airport_description": "Queen Alia",
        "latitude": "31.966667",
        "longitude": "35.983333"
    },
    {
        "airport_name": "Amritsar",
        "airport_code": "ATQ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Sri Guru Ram Dass Jee",
        "latitude": "31.709722",
        "longitude": "74.797222"
    },
    {
        "airport_name": "Amsterdam",
        "airport_code": "AMS",
        "country_name": "Netherlands",
        "country_code": "NL",
        "country_long_code": "NLD",
        "airport_description": "Schiphol Airport",
        "latitude": "52.308611",
        "longitude": "4.763889"
    },
    {
        "airport_name": "Anchorage",
        "airport_code": "ANC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Ted Stevens International",
        "latitude": "61.177739",
        "longitude": "-149.9903811"
    },
    {
        "airport_name": "\u00c4ngelholm-Helsingborg",
        "airport_code": "AGH",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "\u00c4ngelholm-Helsingborg Airport",
        "latitude": "56.2961",
        "longitude": "12.8471"
    },
    {
        "airport_name": "Ankang",
        "airport_code": "AKA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Ankang Wulipu Airport",
        "latitude": "32.7081",
        "longitude": "108.9316"
    },
    {
        "airport_name": "Ankara",
        "airport_code": "ESB",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Esenboga",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Ankara",
        "airport_code": "ANK",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Ankara Esenbo\u011fa International Airport",
        "latitude": "40.1281",
        "longitude": "32.9951"
    },
    {
        "airport_name": "Antalya",
        "airport_code": "AYT",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Antalya",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Antananarivo",
        "airport_code": "TNR",
        "country_name": "Madagascar Island",
        "country_code": "MG",
        "country_long_code": "MDG",
        "airport_description": "Ivato International Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Apalit",
        "airport_code": "APL",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Apalit Airport",
        "latitude": "-15.1056",
        "longitude": "39.2818"
    },
    {
        "airport_name": "Aqaba",
        "airport_code": "AQJ",
        "country_name": "Jordan",
        "country_code": "JO",
        "country_long_code": "JOR",
        "airport_description": "King Hussein International Airport",
        "latitude": "29.6116",
        "longitude": "35.0181"
    },
    {
        "airport_name": "Arar",
        "airport_code": "RAE",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Arar Airport",
        "latitude": "30.966667",
        "longitude": "40.983333"
    },
    {
        "airport_name": "Ararat",
        "airport_code": "ARY",
        "country_name": "Australia",
        "country_code": "AU",
        "country_long_code": "AUS",
        "airport_description": "Ararat Airport",
        "latitude": "-37.3097",
        "longitude": "142.989"
    },
    {
        "airport_name": "Arkhangelsk",
        "airport_code": "ARH",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Talagi Airport",
        "latitude": "5.537",
        "longitude": "12.3547"
    },
    {
        "airport_name": "Arusha",
        "airport_code": "JRO",
        "country_name": "Tanzania (United Republic)",
        "country_code": "TZ",
        "country_long_code": "TZA",
        "airport_description": "Kilimanjaro International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Asmara",
        "airport_code": "ASM",
        "country_name": "Eritrea",
        "country_code": "ER",
        "country_long_code": "ERI",
        "airport_description": "Asmara International",
        "latitude": "15.291944",
        "longitude": "38.910556"
    },
    {
        "airport_name": "Aspen",
        "airport_code": "ASE",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Aspen-Pitkin County Airport",
        "latitude": "39.2232",
        "longitude": "-106.869"
    },
    {
        "airport_name": "Astana",
        "airport_code": "NQZ",
        "country_name": "Kazakhstan",
        "country_code": "KZ",
        "country_long_code": "KAZ",
        "airport_description": "Nursultan Nazarbayev International Airport",
        "latitude": "51.027810",
        "longitude": "71.461200"
    },
    {
        "airport_name": "Asunci\u00f3n",
        "airport_code": "ASU",
        "country_name": "Paraguay",
        "country_code": "PY",
        "country_long_code": "PRY",
        "airport_description": "Silvio Pettirossi International Airport",
        "latitude": "-25.2399",
        "longitude": "-57.5205"
    },
    {
        "airport_name": "Aswan",
        "airport_code": "ASW",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Aswan International Airport",
        "latitude": "23.9644",
        "longitude": "32.8199"
    },
    {
        "airport_name": "Asyut",
        "airport_code": "ATZ",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Asyut Airport",
        "latitude": "27.0465",
        "longitude": "31.0119"
    },
    {
        "airport_name": "Athens",
        "airport_code": "ATH",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Athens International E. Venizelos",
        "latitude": "37.936389",
        "longitude": "23.944444"
    },
    {
        "airport_name": "Atlanta",
        "airport_code": "ATL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Hartsfield-Jackson Int",
        "latitude": "33.636667",
        "longitude": "-84.428056"
    },
    {
        "airport_name": "Auckland",
        "airport_code": "AKL",
        "country_name": "New Zealand",
        "country_code": "NZ",
        "country_long_code": "NZL",
        "airport_description": "Auckland International",
        "latitude": "-37.008056",
        "longitude": "174.791667"
    },
    {
        "airport_name": "Aurangabad",
        "airport_code": "IXU",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Aurangabad",
        "latitude": "19.883333",
        "longitude": "75.416667"
    },
    {
        "airport_name": "Austin",
        "airport_code": "AUS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Bergstrom International",
        "latitude": "30.194444",
        "longitude": "-97.67"
    },
    {
        "airport_name": "Bacolod",
        "airport_code": "BCD",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Bacolod-Silay Airport",
        "latitude": "10.633333",
        "longitude": "122.933333"
    },
    {
        "airport_name": "Badajoz",
        "airport_code": "BJZ",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Badajoz Airport",
        "latitude": "38.8913",
        "longitude": "-6.8213"
    },
    {
        "airport_name": "Bagdogra",
        "airport_code": "IXB",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Bagdogra",
        "latitude": "26.733333",
        "longitude": "88.333333"
    },
    {
        "airport_name": "Baghdad",
        "airport_code": "BGW",
        "country_name": "Iraq",
        "country_code": "IQ",
        "country_long_code": "IRQ",
        "airport_description": "Baghdad international airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Bahawalpur",
        "airport_code": "BHV",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Bahawalpur Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Bah\u00eda Blanca",
        "airport_code": "BHI",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Comandante Espora Airport",
        "latitude": "-38.725",
        "longitude": "-62.1693"
    },
    {
        "airport_name": "Bahrain",
        "airport_code": "BAH",
        "country_name": "Bahrain",
        "country_code": "BH",
        "country_long_code": "BHR",
        "airport_description": "Bahrain International",
        "latitude": "26",
        "longitude": "50.5"
    },
    {
        "airport_name": "Baia Mare",
        "airport_code": "BAY",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Baia Mare Airport",
        "latitude": "47.6584",
        "longitude": "23.47"
    },
    {
        "airport_name": "Baicheng",
        "airport_code": "AEB",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Baicheng Chang'an Airport",
        "latitude": "23.7214",
        "longitude": "106.9606"
    },
    {
        "airport_name": "Baidoa",
        "airport_code": "BAR",
        "country_name": "Somalia",
        "country_code": "SO",
        "country_long_code": "SOM",
        "airport_description": "Baidoa Airport",
        "latitude": "0.2",
        "longitude": "-176.4667"
    },
    {
        "airport_name": "Baku",
        "airport_code": "GYD",
        "country_name": "Azerbaijan",
        "country_code": "AZ",
        "country_long_code": "AZE",
        "airport_description": "Heydar Aliyev International Airport",
        "latitude": "40.4675",
        "longitude": "50.0467"
    },
    {
        "airport_name": "Bali",
        "airport_code": "DPS",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Ngurah Rai International Airport",
        "latitude": "-8.748056",
        "longitude": "115.167222"
    },
    {
        "airport_name": "Bal\u0131kesir",
        "airport_code": "EDO",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Bal\u0131kesir Koca Seyit Airport",
        "latitude": "39.5546",
        "longitude": "27.0138"
    },
    {
        "airport_name": "Balikpapan",
        "airport_code": "BPN",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sultan Aji Muhammad Sulaiman Sepinggan International Airport",
        "latitude": "-1.266667",
        "longitude": "116.9"
    },
    {
        "airport_name": "Baltimore",
        "airport_code": "BWI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Baltimore/Washington International",
        "latitude": "39.175278",
        "longitude": "-76.668333"
    },
    {
        "airport_name": "Bamako",
        "airport_code": "BKO",
        "country_name": "Mali",
        "country_code": "ML",
        "country_long_code": "MLI",
        "airport_description": "Senou International",
        "latitude": "12.633333",
        "longitude": "-8.016667"
    },
    {
        "airport_name": "Banda Aceh",
        "airport_code": "BTJ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sultan Iskandar Muda International Airport",
        "latitude": "5.5235",
        "longitude": "95.4203"
    },
    {
        "airport_name": "Bandar Lampung",
        "airport_code": "TKG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Radin Inten II Airport",
        "latitude": "-5.2423",
        "longitude": "105.1786"
    },
    {
        "airport_name": "Bandar Seri Begawan",
        "airport_code": "BWN",
        "country_name": "Brunei Darussalam",
        "country_code": "BN",
        "country_long_code": "BRN",
        "airport_description": "Brunei International",
        "latitude": "4.944167",
        "longitude": "114.928333"
    },
    {
        "airport_name": "Bandung",
        "airport_code": "BDO",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Husein Sastranegara International Airport",
        "latitude": "-6.9006",
        "longitude": "107.5763"
    },
    {
        "airport_name": "Bangkok",
        "airport_code": "BKK",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Suvarnabhumi International Airport",
        "latitude": "13.681111",
        "longitude": "100.747222"
    },
    {
        "airport_name": "Bangui",
        "airport_code": "BGF",
        "country_name": "Central African Republic",
        "country_code": "CF",
        "country_long_code": "CAF",
        "airport_description": "Mpoko International",
        "latitude": "4.383333",
        "longitude": "18.566667"
    },
    {
        "airport_name": "Banjarmasin",
        "airport_code": "BDJ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Syamsudin Noor",
        "latitude": "-3.283333",
        "longitude": "114.683333"
    },
    {
        "airport_name": "Banjul",
        "airport_code": "BJL",
        "country_name": "Gambia",
        "country_code": "GM",
        "country_long_code": "GMB",
        "airport_description": "International",
        "latitude": "13.35",
        "longitude": "-16.666667"
    },
    {
        "airport_name": "Banyuwangi",
        "airport_code": "BWX",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Banyuwangi International Airport",
        "latitude": "-8.4574",
        "longitude": "114.14"
    },
    {
        "airport_name": "Baoshan",
        "airport_code": "BSD",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Baoshan Yunrui Airport",
        "latitude": "25.053",
        "longitude": "99.1683"
    },
    {
        "airport_name": "Baotou",
        "airport_code": "BAV",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Baotou Airport",
        "latitude": "40.56",
        "longitude": "109.997"
    },
    {
        "airport_name": "Barcelona",
        "airport_code": "BCN",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Barcelona-El Prat Airport",
        "latitude": "41.3",
        "longitude": "2.083333"
    },
    {
        "airport_name": "Bari",
        "airport_code": "BRI",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Palese",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Barisal",
        "airport_code": "BZL",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Barisal Airport",
        "latitude": "22.801",
        "longitude": "90.3012"
    },
    {
        "airport_name": "Basrah",
        "airport_code": "BSR",
        "country_name": "Iraq",
        "country_code": "IQ",
        "country_long_code": "IRQ",
        "airport_description": "Basra International Airport",
        "latitude": "30.5491",
        "longitude": "47.6621"
    },
    {
        "airport_name": "Bastia",
        "airport_code": "BIA",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Poretta",
        "latitude": "42.7",
        "longitude": "9.45"
    },
    {
        "airport_name": "Batman",
        "airport_code": "BAL",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Batman",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Baton Rouge",
        "airport_code": "BTR",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Baton Rouge Metropolitan Airport",
        "latitude": "30.533333",
        "longitude": "-91.15"
    },
    {
        "airport_name": "Batu Besar",
        "airport_code": "BTH",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Hang Nadim",
        "latitude": "1.066667",
        "longitude": "104.133333"
    },
    {
        "airport_name": "Batumi",
        "airport_code": "BUS",
        "country_name": "Georgia",
        "country_code": "GE",
        "country_long_code": "GEO",
        "airport_description": "Batumi International Airport",
        "latitude": "41.6103",
        "longitude": "41.5997"
    },
    {
        "airport_name": "Bayannur",
        "airport_code": "RLK",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Bayannur Tianjitai Airport",
        "latitude": "40.9264",
        "longitude": "107.7416"
    },
    {
        "airport_name": "Bazhong",
        "airport_code": "BZX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Bazhong Enyang Airport",
        "latitude": "31.7361",
        "longitude": "106.641"
    },
    {
        "airport_name": "Beihai",
        "airport_code": "BHY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Beihai Fucheng Airport",
        "latitude": "21.5394",
        "longitude": "109.294"
    },
    {
        "airport_name": "Beijing",
        "airport_code": "BJS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "All Airports",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Beijing",
        "airport_code": "PEK",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Beijing Capital International Airport",
        "latitude": "40.063333",
        "longitude": "116.584444"
    },
    {
        "airport_name": "Beijing",
        "airport_code": "PKX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Beijing Daxing International Airport",
        "latitude": "39.509805",
        "longitude": "116.407932"
    },
    {
        "airport_name": "Beirut",
        "airport_code": "BEY",
        "country_name": "Lebanon",
        "country_code": "LB",
        "country_long_code": "LBN",
        "airport_description": "Rafic Hariri International",
        "latitude": "33.820833",
        "longitude": "35.488333"
    },
    {
        "airport_name": "Belfast",
        "airport_code": "BHD",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "George Best Belfast City Airport",
        "latitude": "54.6181",
        "longitude": "-5.8725"
    },
    {
        "airport_name": "Belgrade",
        "airport_code": "BEG",
        "country_name": "Serbia",
        "country_code": "RS",
        "country_long_code": "SCG",
        "airport_description": "Nikola Tesla",
        "latitude": "44.819167",
        "longitude": "20.306944"
    },
    {
        "airport_name": "Bemidji",
        "airport_code": "BJI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Bemidji Regional Airport",
        "latitude": "47.5107",
        "longitude": "-94.9347"
    },
    {
        "airport_name": "Bengaluru",
        "airport_code": "BLR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Kempegowda International",
        "latitude": "12.966667",
        "longitude": "77.6"
    },
    {
        "airport_name": "Bengkulu",
        "airport_code": "BKS",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Fatmawati Soekarno Airport",
        "latitude": "-3.8637",
        "longitude": "102.339"
    },
    {
        "airport_name": "Berlin",
        "airport_code": "BER",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Berlin Brandenburg",
        "latitude": "52.516667",
        "longitude": "13.4"
    },
    {
        "airport_name": "Berlin",
        "airport_code": "TXL",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Berlin Tegel  Airport",
        "latitude": "52.5597",
        "longitude": "13.2877"
    },
    {
        "airport_name": "Biarritz",
        "airport_code": "BIQ",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Pays Basque",
        "latitude": "43.466667",
        "longitude": "-1.533333"
    },
    {
        "airport_name": "Bilbao",
        "airport_code": "BIO",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Bilbao Airport",
        "latitude": "43.301111",
        "longitude": "-2.910556"
    },
    {
        "airport_name": "Binghamton",
        "airport_code": "BGM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Greater Binghamton Airport",
        "latitude": "42.2087",
        "longitude": "-75.9798"
    },
    {
        "airport_name": "Bingol",
        "airport_code": "BGG",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Bingol",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Bintulu",
        "airport_code": "BTU",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Bintulu Airport",
        "latitude": "3.2",
        "longitude": "113.033333"
    },
    {
        "airport_name": "Birmingham",
        "airport_code": "BHX",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Birmingham International Airport",
        "latitude": "52.45",
        "longitude": "-1.75"
    },
    {
        "airport_name": "Birmingham",
        "airport_code": "BHM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Birmingham-Shuttlesworth International Airport",
        "latitude": "33.5629",
        "longitude": "-86.7535"
    },
    {
        "airport_name": "Bisha",
        "airport_code": "BHH",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Bisha Airport",
        "latitude": "19.983333",
        "longitude": "42.65"
    },
    {
        "airport_name": "Bloemfontein",
        "airport_code": "BFN",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Bloemfontein International",
        "latitude": "-29.0925638",
        "longitude": "26.2961677"
    },
    {
        "airport_name": "Bloomington",
        "airport_code": "MSP",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Minneapolis-Saint Paul International Airport",
        "latitude": "44.883333",
        "longitude": "-93.216944"
    },
    {
        "airport_name": "Bloomington",
        "airport_code": "BMI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Central Illinois Regional Airport",
        "latitude": "40.4771",
        "longitude": "-88.9159"
    },
    {
        "airport_name": "Bod\u00f8",
        "airport_code": "BOO",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Bod\u00f8 Airport",
        "latitude": "67.2692",
        "longitude": "14.3653"
    },
    {
        "airport_name": "Bodrum",
        "airport_code": "BJV",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Milas",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Bogota",
        "airport_code": "BOG",
        "country_name": "Colombia",
        "country_code": "CO",
        "country_long_code": "COL",
        "airport_description": "El Dorado International",
        "latitude": "4.703056",
        "longitude": "-74.138333"
    },
    {
        "airport_name": "Boise ",
        "airport_code": "BOI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Boise Air Terminal Airport",
        "latitude": "43.564444",
        "longitude": "-116.222778"
    },
    {
        "airport_name": "Bologna",
        "airport_code": "BLQ",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Guglielmo Marconi",
        "latitude": "44.535556",
        "longitude": "11.288611"
    },
    {
        "airport_name": "Borapalma",
        "airport_code": "BPL",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Bhopal Raja Bhoj Airport",
        "latitude": "44.895",
        "longitude": "82.3"
    },
    {
        "airport_name": "Bordeaux",
        "airport_code": "BOD",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Merignac",
        "latitude": "44.828611",
        "longitude": "-0.715278"
    },
    {
        "airport_name": "Boston",
        "airport_code": "BOS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Edward L Logan International",
        "latitude": "42.363056",
        "longitude": "-71"
    },
    {
        "airport_name": "Bozeman",
        "airport_code": "BTM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Bozeman Yellowstone International Airport",
        "latitude": "45.9548",
        "longitude": "-112.4975"
    },
    {
        "airport_name": "Brainerd",
        "airport_code": "BRD",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Brainerd Lakes Regional Airport",
        "latitude": "46.3983",
        "longitude": "-94.1381"
    },
    {
        "airport_name": "Bras\u00edlia",
        "airport_code": "BSB",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Bras\u00edlia International Airport",
        "latitude": "-15.8692",
        "longitude": "-47.9208"
    },
    {
        "airport_name": "Bratislava",
        "airport_code": "BTS",
        "country_name": "Slovakia",
        "country_code": "SK",
        "country_long_code": "SVK",
        "airport_description": "M. R. \u0160tef\u00e1nik Airport",
        "latitude": "48.1702",
        "longitude": "17.2127"
    },
    {
        "airport_name": "Brazzaville",
        "airport_code": "BZV",
        "country_name": "Congo Brazzaville",
        "country_code": "CG",
        "country_long_code": "",
        "airport_description": "Maya-Maya",
        "latitude": "-4.25",
        "longitude": "15.25"
    },
    {
        "airport_name": "Bremen",
        "airport_code": "BRE",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Bremen",
        "latitude": "53.05",
        "longitude": "8.783333"
    },
    {
        "airport_name": "Brest",
        "airport_code": "BES",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Bretagne",
        "latitude": "48.45",
        "longitude": "-4.416667"
    },
    {
        "airport_name": "Brindisi",
        "airport_code": "BDS",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Casale",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Brisbane",
        "airport_code": "BNE",
        "country_name": "Australia",
        "country_code": "AU",
        "country_long_code": "AUS",
        "airport_description": "Brisbane",
        "latitude": "-27.383333",
        "longitude": "153.116667"
    },
    {
        "airport_name": "Brunswick",
        "airport_code": "BQK",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Brunswick Golden Isles Airport",
        "latitude": "31.2588",
        "longitude": "-81.4665"
    },
    {
        "airport_name": "Brussels",
        "airport_code": "BRU",
        "country_name": "Belgium",
        "country_code": "BE",
        "country_long_code": "BEL",
        "airport_description": "Brussels Airport",
        "latitude": "50.902222",
        "longitude": "4.485833"
    },
    {
        "airport_name": "Bucharest",
        "airport_code": "BUH",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Bucharest Henri Coand\u0103 International Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Bucharest",
        "airport_code": "OTP",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Henri Coand\u0103 International Airport",
        "latitude": "44.5711",
        "longitude": "26.085"
    },
    {
        "airport_name": "Budapest",
        "airport_code": "BUD",
        "country_name": "Hungary",
        "country_code": "HU",
        "country_long_code": "HUN",
        "airport_description": "Liszt Ferenc International",
        "latitude": "47.436667",
        "longitude": "19.255556"
    },
    {
        "airport_name": "Buenos Aires",
        "airport_code": "BUE",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Buenos Aires Airport",
        "latitude": "-34.6037",
        "longitude": "-58.3816"
    },
    {
        "airport_name": "Buffalo",
        "airport_code": "BUF",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Buffalo Niagara International",
        "latitude": "42.9397098",
        "longitude": "-78.7320816"
    },
    {
        "airport_name": "Bujumbura",
        "airport_code": "BJM",
        "country_name": "Burundi",
        "country_code": "BI",
        "country_long_code": "BDI",
        "airport_description": "Melchior Ndadaye International Airport",
        "latitude": "-3.316667",
        "longitude": "29.316667"
    },
    {
        "airport_name": "Buon Ma Thuot",
        "airport_code": "BMV",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Buon Ma Thuot Airport",
        "latitude": "12.6683",
        "longitude": "108.1205"
    },
    {
        "airport_name": "Burgos",
        "airport_code": "RGS",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Burgos Airport",
        "latitude": "42.3578",
        "longitude": "-3.6208"
    },
    {
        "airport_name": "Busan",
        "airport_code": "PUS",
        "country_name": "South Korea",
        "country_code": "KR",
        "country_long_code": "KOR",
        "airport_description": "Gimhae International Airport",
        "latitude": "35.1796",
        "longitude": "128.9385"
    },
    {
        "airport_name": "Butuan",
        "airport_code": "BXU",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Butuan Airport",
        "latitude": "8.95139",
        "longitude": "125.478"
    },
    {
        "airport_name": "Ca Mau",
        "airport_code": "CAH",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Ca Mau Airport",
        "latitude": "9.1777",
        "longitude": "105.1778"
    },
    {
        "airport_name": "Cagayan de Oro",
        "airport_code": "CGY",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Laguindingan Airport",
        "latitude": "8.415556",
        "longitude": "124.611111"
    },
    {
        "airport_name": "Cairo",
        "airport_code": "CAI",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Cairo International",
        "latitude": "30.121944",
        "longitude": "31.405556"
    },
    {
        "airport_name": "Calgary",
        "airport_code": "YYC",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Calgary International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Cali",
        "airport_code": "CLO",
        "country_name": "Colombia",
        "country_code": "CO",
        "country_long_code": "COL",
        "airport_description": "Alfonso Bonilla Arag\u00f3n International Airport",
        "latitude": "3.5432",
        "longitude": "-76.3816"
    },
    {
        "airport_name": "Calvi",
        "airport_code": "CLY",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Ste Catherine",
        "latitude": "42.533333",
        "longitude": "8.8"
    },
    {
        "airport_name": "Campeche",
        "airport_code": "CPE",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Ing. Alberto Acu\u00f1a Ongay International Airport",
        "latitude": "19.8168",
        "longitude": "-90.5003"
    },
    {
        "airport_name": "Can Tho",
        "airport_code": "VCA",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Can Tho International Airport",
        "latitude": "10.0851",
        "longitude": "105.7119"
    },
    {
        "airport_name": "Cancun",
        "airport_code": "CUN",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "International",
        "latitude": "21.036667",
        "longitude": "-86.876944"
    },
    {
        "airport_name": "Cape Town",
        "airport_code": "CPT",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Cape Town International",
        "latitude": "-33.964722",
        "longitude": "18.601667"
    },
    {
        "airport_name": "Caracas",
        "airport_code": "CCS",
        "country_name": "Venezuela",
        "country_code": "VE",
        "country_long_code": "VEN",
        "airport_description": "Sim\u00f3n Bol\u00edvar International Airport",
        "latitude": "10.6031",
        "longitude": "-66.9906"
    },
    {
        "airport_name": "Cardiff",
        "airport_code": "CWL",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Cardiff Airport",
        "latitude": "51.3967",
        "longitude": "-3.3433"
    },
    {
        "airport_name": "Casablanca",
        "airport_code": "CMN",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Mohammed V",
        "latitude": "33.366667",
        "longitude": "-7.583333"
    },
    {
        "airport_name": "Catania",
        "airport_code": "CTA",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Fontanarossa",
        "latitude": "37.466667",
        "longitude": "15.066667"
    },
    {
        "airport_name": "Cedar City",
        "airport_code": "CDC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Cedar City Regional Airport",
        "latitude": "37.701",
        "longitude": "-113.0988"
    },
    {
        "airport_name": "Chandigarh",
        "airport_code": "IXC",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Chandigarh",
        "latitude": "30.666667",
        "longitude": "76.8"
    },
    {
        "airport_name": "Changbaishan",
        "airport_code": "NBS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Changbaishan Airport",
        "latitude": "42.088",
        "longitude": "127.548"
    },
    {
        "airport_name": "Changchun",
        "airport_code": "CGQ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Changchun Longjia International Airport",
        "latitude": "43.9962",
        "longitude": "125.6844"
    },
    {
        "airport_name": "Changsha",
        "airport_code": "CSX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Changsha Huanghua International",
        "latitude": "28.071111",
        "longitude": "112.958333"
    },
    {
        "airport_name": "Changzhou",
        "airport_code": "CZX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Changzhou Benniu Airport",
        "latitude": "31.9197",
        "longitude": "119.7798"
    },
    {
        "airport_name": "Chania",
        "airport_code": "CHQ",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Chania Intenational Airport",
        "latitude": "35.531667",
        "longitude": "24.149722"
    },
    {
        "airport_name": "Chaoyang",
        "airport_code": "CHG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Chaoyang Airport",
        "latitude": "41.5381",
        "longitude": "120.4347"
    },
    {
        "airport_name": "Chaozhou",
        "airport_code": "CWJ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Chaozhou Huangjiang Airport",
        "latitude": "23.2739",
        "longitude": "99.3732"
    },
    {
        "airport_name": "Charleston",
        "airport_code": "CRW",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Yeager Airport",
        "latitude": "38.3731",
        "longitude": "-81.5932"
    },
    {
        "airport_name": "Charlotte",
        "airport_code": "CLT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Douglas International",
        "latitude": "35.216667",
        "longitude": "-80.933333"
    },
    {
        "airport_name": "Charlottetown",
        "airport_code": "YYG",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Charlottetown Airport",
        "latitude": "46.290001",
        "longitude": "-63.121111"
    },
    {
        "airport_name": "Chengdu",
        "airport_code": "CTU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Chengdu Shuangliu International",
        "latitude": "30.578611",
        "longitude": "103.947222"
    },
    {
        "airport_name": "Chengdu",
        "airport_code": "TFU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Chengdu Tianfu International Airport",
        "latitude": "30.578611",
        "longitude": "103.947222"
    },
    {
        "airport_name": "Chennai",
        "airport_code": "MAA",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Chennai International",
        "latitude": "12.994722",
        "longitude": "80.175278"
    },
    {
        "airport_name": "Chetumal",
        "airport_code": "CTM",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Chetumal International Airport",
        "latitude": "18.5047",
        "longitude": "-88.3268"
    },
    {
        "airport_name": "Chiang Mai",
        "airport_code": "CNX",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Chiang Mai International Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Chicago",
        "airport_code": "ORD",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "O'Hare International Airport ",
        "latitude": "41.978611",
        "longitude": "-87.904722"
    },
    {
        "airport_name": "Chicago",
        "airport_code": "CHI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Chicago Metropolitan Area Airports",
        "latitude": "41.9742",
        "longitude": "-87.9073"
    },
    {
        "airport_name": "Chicago",
        "airport_code": "MDW",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Chicago Midway International Airport",
        "latitude": "41.7868",
        "longitude": "-87.7522"
    },
    {
        "airport_name": "Chihuahua",
        "airport_code": "CUU",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Roberto Fierro Villalobos Intl Airport",
        "latitude": "28.7029",
        "longitude": "-105.9646"
    },
    {
        "airport_name": "Chios",
        "airport_code": "JKH",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Chios Island National Airport ",
        "latitude": "38.3432",
        "longitude": "26.1406"
    },
    {
        "airport_name": "Chittagong ",
        "airport_code": "CGP",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Shah Amanat International Airport",
        "latitude": "22.266667",
        "longitude": "91.816667"
    },
    {
        "airport_name": "Chongqing",
        "airport_code": "CKG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Chongqing Jiangbei International",
        "latitude": "29.719167",
        "longitude": "106.641667"
    },
    {
        "airport_name": "Christchurch",
        "airport_code": "CHC",
        "country_name": "New Zealand",
        "country_code": "NZ",
        "country_long_code": "NZL",
        "airport_description": "Christchurch International Airport",
        "latitude": "-43.4876261",
        "longitude": "172.5348277"
    },
    {
        "airport_name": "Chu Lai",
        "airport_code": "VCL",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Chu Lai International Airport",
        "latitude": "15.4077",
        "longitude": "108.7065"
    },
    {
        "airport_name": "Ciudad del Carmen",
        "airport_code": "CME",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Ciudad del Carmen International Airport",
        "latitude": "18.6537",
        "longitude": "-91.799"
    },
    {
        "airport_name": "Ciudad Ju\u00e1rez",
        "airport_code": "CJS",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Abraham Gonz\u00e1lez International Airport",
        "latitude": "31.6361",
        "longitude": "-106.4291"
    },
    {
        "airport_name": "Ciudad Obreg\u00f3n",
        "airport_code": "CEN",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Ciudad Obreg\u00f3n International Airport",
        "latitude": "27.3926",
        "longitude": "-109.8331"
    },
    {
        "airport_name": "Clermont Ferrand",
        "airport_code": "CFE",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Auvergne",
        "latitude": "45.783333",
        "longitude": "3.166667"
    },
    {
        "airport_name": "Cleveland",
        "airport_code": "CLE",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Hopkins International",
        "latitude": "41.416667",
        "longitude": "-81.85"
    },
    {
        "airport_name": "Cluj Napoca",
        "airport_code": "CLJ",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Avram Iancu Cluj International Airport",
        "latitude": "46.785278",
        "longitude": "23.686111"
    },
    {
        "airport_name": "Coimbatore",
        "airport_code": "CJB",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "International",
        "latitude": "11.03",
        "longitude": "77.043333"
    },
    {
        "airport_name": "Colima",
        "airport_code": "CLQ",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Licenciado Miguel de la Madrid Airport",
        "latitude": "19.277",
        "longitude": "-103.5775"
    },
    {
        "airport_name": "Cologne Bonn",
        "airport_code": "CGN",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Cologne Bonn Airport",
        "latitude": "50.866667",
        "longitude": "7.15"
    },
    {
        "airport_name": "Colombo",
        "airport_code": "CMB",
        "country_name": "Sri Lanka",
        "country_code": "LK",
        "country_long_code": "LKA",
        "airport_description": "Bandaranaike International",
        "latitude": "7.179167",
        "longitude": "79.883056"
    },
    {
        "airport_name": "Columbus",
        "airport_code": "CMH",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Port Columbus International Airport",
        "latitude": "40",
        "longitude": "-82.883333"
    },
    {
        "airport_name": "Columbus",
        "airport_code": "CSG",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Columbus Metropolitan Airport",
        "latitude": "32.5163",
        "longitude": "-84.9389"
    },
    {
        "airport_name": "Columbus",
        "airport_code": "GTR",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Golden Triangle Regional Airport",
        "latitude": "33.4503",
        "longitude": "-88.5914"
    },
    {
        "airport_name": "Comodoro Rivadavia",
        "airport_code": "CRD",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "General Enrique Mosconi International Airport",
        "latitude": "-45.7853",
        "longitude": "-67.4656"
    },
    {
        "airport_name": "Con Dao",
        "airport_code": "VCS",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Con Dao Airport",
        "latitude": "8.7318",
        "longitude": "106.6327"
    },
    {
        "airport_name": "Conakry",
        "airport_code": "CKY",
        "country_name": "Guinea",
        "country_code": "GN",
        "country_long_code": "",
        "airport_description": "International",
        "latitude": "9.566667",
        "longitude": "-13.616667"
    },
    {
        "airport_name": "Concord",
        "airport_code": "USA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Concord Regional Airport",
        "latitude": "35.3878",
        "longitude": "-80.7091"
    },
    {
        "airport_name": "Constantine",
        "airport_code": "CZL",
        "country_name": "Algeria",
        "country_code": "DZ",
        "country_long_code": "DZA",
        "airport_description": "Mohamed Boudiaf International Airport",
        "latitude": "36.276",
        "longitude": "6.6204"
    },
    {
        "airport_name": "Copenhagen",
        "airport_code": "CPH",
        "country_name": "Denmark",
        "country_code": "DK",
        "country_long_code": "DNK",
        "airport_description": "Kastrup",
        "latitude": "55.618056",
        "longitude": "12.655833"
    },
    {
        "airport_name": "C\u00f3rdoba",
        "airport_code": "ODB",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "C\u00f3rdoba Airport",
        "latitude": "37.841",
        "longitude": "-4.8489"
    },
    {
        "airport_name": "C\u00f3rdoba",
        "airport_code": "COR",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Ingeniero Ambrosio L.V. Taravella International Airport",
        "latitude": "-31.3236",
        "longitude": "-64.2079"
    },
    {
        "airport_name": "Corrientes",
        "airport_code": "CNQ",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Doctor Fernando Piragine Niveyro International Airport",
        "latitude": "-27.4455",
        "longitude": "-58.7619"
    },
    {
        "airport_name": "Cotabato",
        "airport_code": "CBO",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Cotabato Airport",
        "latitude": "7.1652398",
        "longitude": "124.2099991"
    },
    {
        "airport_name": "Cotonou",
        "airport_code": "COO",
        "country_name": "Benin",
        "country_code": "BJ",
        "country_long_code": "BEN",
        "airport_description": "Cadjehoun",
        "latitude": "6.35",
        "longitude": "2.383333"
    },
    {
        "airport_name": "Cox''s Bazar",
        "airport_code": "CXB",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Cox's Bazar",
        "latitude": "21.4506727",
        "longitude": "91.9640952"
    },
    {
        "airport_name": "Culiac\u00e1n",
        "airport_code": "CUL",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Bachigualato Federal International Airport",
        "latitude": "24.7645",
        "longitude": "-107.4747"
    },
    {
        "airport_name": "Curitiba",
        "airport_code": "CWB",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Afonso Pena International Airport",
        "latitude": "-25.5285",
        "longitude": "-49.1758"
    },
    {
        "airport_name": "Cusco",
        "airport_code": "CUZ",
        "country_name": "Peru",
        "country_code": "PE",
        "country_long_code": "PER",
        "airport_description": "Alejandro Velasco Astete International Airport",
        "latitude": "-13.5357",
        "longitude": "-71.9388"
    },
    {
        "airport_name": "Da Lat",
        "airport_code": "DLI",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Lien Khuong Airport",
        "latitude": "11.7516",
        "longitude": "108.3747"
    },
    {
        "airport_name": "Da Nang",
        "airport_code": "DAD",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Da Nang International Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Dakar",
        "airport_code": "DKR",
        "country_name": "Senegal",
        "country_code": "SN",
        "country_long_code": "SEN",
        "airport_description": "Leopold Sedar Senghor",
        "latitude": "14.739722",
        "longitude": "-17.490278"
    },
    {
        "airport_name": "Dakar",
        "airport_code": "DSS",
        "country_name": "Senegal",
        "country_code": "SN",
        "country_long_code": "SEN",
        "airport_description": "Blaise Diagne International Airport",
        "latitude": "14.6708543",
        "longitude": "-17.0699224"
    },
    {
        "airport_name": "Dakhla",
        "airport_code": "VIL",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Dakhla",
        "latitude": "23.733333",
        "longitude": "-15.916667"
    },
    {
        "airport_name": "Dalaman",
        "airport_code": "DLM",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Dalaman",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Dali",
        "airport_code": "DLU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Dali Airport",
        "latitude": "25.6497",
        "longitude": "100.3194"
    },
    {
        "airport_name": "Dalian",
        "airport_code": "DLC",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Dalian Zhoushuizi International",
        "latitude": "38.965556",
        "longitude": "121.538611"
    },
    {
        "airport_name": "Dallas",
        "airport_code": "DAL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Dallas Love Field Airport",
        "latitude": "32.852778",
        "longitude": "-96.85"
    },
    {
        "airport_name": "Dallas",
        "airport_code": "DFW",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Dallas Ft Worth International",
        "latitude": "32.896944",
        "longitude": "-97.038056"
    },
    {
        "airport_name": "Damascus",
        "airport_code": "DAM",
        "country_name": "Syrian Arab Republic",
        "country_code": "SY",
        "country_long_code": "SYR",
        "airport_description": "Damascus International",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Dammam",
        "airport_code": "DMM",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "King Fahd International",
        "latitude": "26.471111",
        "longitude": "49.797778"
    },
    {
        "airport_name": "Daqing",
        "airport_code": "DQA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Daqing Sartu Airport",
        "latitude": "46.7465",
        "longitude": "124.1172"
    },
    {
        "airport_name": "Dar es Salaam",
        "airport_code": "DAR",
        "country_name": "Tanzania (United Republic)",
        "country_code": "TZ",
        "country_long_code": "TZA",
        "airport_description": "Julius Nyerere International Airport",
        "latitude": "-6.875556",
        "longitude": "39.201944"
    },
    {
        "airport_name": "Datong",
        "airport_code": "DAT",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Datong Yungang Airport",
        "latitude": "40.0603",
        "longitude": "113.4828"
    },
    {
        "airport_name": "Davao",
        "airport_code": "DVO",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Francisco Bangoy International Airport",
        "latitude": "7.125556",
        "longitude": "125.645833"
    },
    {
        "airport_name": "Dawadmi",
        "airport_code": "DWD",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Dawadmi Domestic Airport",
        "latitude": "24.449722",
        "longitude": "44.121111"
    },
    {
        "airport_name": "Dayton",
        "airport_code": "DAY",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "James M. Cox Dayton International Airport",
        "latitude": "39.75",
        "longitude": "-84.183333"
    },
    {
        "airport_name": "Daytona Beach",
        "airport_code": "DAB",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Daytona Beach International Airport",
        "latitude": "29.183333",
        "longitude": "-81.05"
    },
    {
        "airport_name": "Dazhou",
        "airport_code": "DZH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Dazhou Heshi Airport",
        "latitude": "31.1302",
        "longitude": "107.429"
    },
    {
        "airport_name": "Deer Lake",
        "airport_code": "YDF",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Deer Lake Reg. Airport",
        "latitude": "49.210833",
        "longitude": "-57.391388"
    },
    {
        "airport_name": "Delhi",
        "airport_code": "DEL",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Indira Gandhi International",
        "latitude": "28.569444",
        "longitude": "77.118056"
    },
    {
        "airport_name": "Denizli",
        "airport_code": "DNZ",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Cardak",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Denver",
        "airport_code": "DEN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Denver International",
        "latitude": "39.861667",
        "longitude": "-104.673056"
    },
    {
        "airport_name": "Detroit",
        "airport_code": "DTW",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Detroit Metropolitan Wayne County Airport",
        "latitude": "42.2132203",
        "longitude": "-83.3550573"
    },
    {
        "airport_name": "Detroit",
        "airport_code": "DTT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Detroit Metropolitan Area Airports",
        "latitude": "42.2162",
        "longitude": "-83.3554"
    },
    {
        "airport_name": "Dhaka",
        "airport_code": "DAC",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Hazrat Shahjalal International",
        "latitude": "23.843333",
        "longitude": "90.397778"
    },
    {
        "airport_name": "Dibrugarh",
        "airport_code": "DIB",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Dibrugarh Airport",
        "latitude": "27.4839",
        "longitude": "95.0169"
    },
    {
        "airport_name": "Dien Bien Phu",
        "airport_code": "DIN",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Dien Bien Phu Airport",
        "latitude": "21.3975",
        "longitude": "103.0084"
    },
    {
        "airport_name": "Dimapur",
        "airport_code": "DMU",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Dimapur Airport",
        "latitude": "25.8839",
        "longitude": "93.7711"
    },
    {
        "airport_name": "Dipolog",
        "airport_code": "DPL",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Dipolog Airport",
        "latitude": "8.601",
        "longitude": "123.334"
    },
    {
        "airport_name": "Diqing",
        "airport_code": "DIG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Diqing Shangri-La Airport",
        "latitude": "27.7936",
        "longitude": "99.6772"
    },
    {
        "airport_name": "Diyarbakir",
        "airport_code": "DIY",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Diyarbakir",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Djerba",
        "airport_code": "DJE",
        "country_name": "Tunisia",
        "country_code": "TN",
        "country_long_code": "TUN",
        "airport_description": "Djerba\u2013Zarzis International Airport",
        "latitude": "33.875",
        "longitude": "10.7756"
    },
    {
        "airport_name": "Djibouti",
        "airport_code": "JIB",
        "country_name": "Djibouti",
        "country_code": "DJ",
        "country_long_code": "DJI",
        "airport_description": "Ambouli",
        "latitude": "11.55",
        "longitude": "43.166667"
    },
    {
        "airport_name": "Doha",
        "airport_code": "DOH",
        "country_name": "Qatar",
        "country_code": "QA",
        "country_long_code": "QAT",
        "airport_description": "Hamad International Airport",
        "latitude": "25.261111",
        "longitude": "51.565"
    },
    {
        "airport_name": "Dong Hoi",
        "airport_code": "VDH",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Dong Hoi Airport",
        "latitude": "17.515",
        "longitude": "106.5905"
    },
    {
        "airport_name": "Dongsheng",
        "airport_code": "DSN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Dongsheng Airport",
        "latitude": "39.4893",
        "longitude": "109.8614"
    },
    {
        "airport_name": "Dongying",
        "airport_code": "DOY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Dongying Shengli Airport",
        "latitude": "37.5086",
        "longitude": "118.7886"
    },
    {
        "airport_name": "Dothan",
        "airport_code": "DHN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Dothan Regional Airport",
        "latitude": "31.3213",
        "longitude": "-85.4496"
    },
    {
        "airport_name": "Douala",
        "airport_code": "DLA",
        "country_name": "Cameroon (Republic of)",
        "country_code": "CM",
        "country_long_code": "CMR",
        "airport_description": "Douala International",
        "latitude": "4.016667",
        "longitude": "9.716667"
    },
    {
        "airport_name": "Dubai",
        "airport_code": "DXB",
        "country_name": "United Arab Emirates",
        "country_code": "AE",
        "country_long_code": "ARE",
        "airport_description": "Dubai International",
        "latitude": "25.25",
        "longitude": "55.333333"
    },
    {
        "airport_name": "Dublin",
        "airport_code": "DUB",
        "country_name": "Ireland (Republic of)",
        "country_code": "IE",
        "country_long_code": "IRL",
        "airport_description": "Dublin International",
        "latitude": "53.433333",
        "longitude": "-6.25"
    },
    {
        "airport_name": "Dubrovnik",
        "airport_code": "DBV",
        "country_name": "Croatia",
        "country_code": "HR",
        "country_long_code": "HRV",
        "airport_description": "Dubrovnik Airport",
        "latitude": "42.561389",
        "longitude": "18.268333"
    },
    {
        "airport_name": "Duesseldorf",
        "airport_code": "DUS",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "International Airport",
        "latitude": "51.289444",
        "longitude": "6.766667"
    },
    {
        "airport_name": "Dumaguete",
        "airport_code": "DGT",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Sibulan Airport",
        "latitude": "9.3",
        "longitude": "123.3"
    },
    {
        "airport_name": "Dunhuang",
        "airport_code": "DNH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Dunhuang Airport",
        "latitude": "40.1611",
        "longitude": "94.8091"
    },
    {
        "airport_name": "Durango",
        "airport_code": "DGO",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Guadalupe Victoria Airport",
        "latitude": "24.1242",
        "longitude": "-104.528"
    },
    {
        "airport_name": "Durban",
        "airport_code": "DUR",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "King Shaka International",
        "latitude": "-29.97",
        "longitude": "30.950556"
    },
    {
        "airport_name": "Dzaoudzi",
        "airport_code": "DZA",
        "country_name": "Mayotte",
        "country_code": "YT",
        "country_long_code": "MYT",
        "airport_description": "Dzaoudzi Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "East London",
        "airport_code": "ELS",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "East London",
        "latitude": "-33.05",
        "longitude": "27.816667"
    },
    {
        "airport_name": "Edinburgh",
        "airport_code": "EDI",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Edinburgh Airport",
        "latitude": "55.95",
        "longitude": "-3.35"
    },
    {
        "airport_name": "Edmonton",
        "airport_code": "YEG",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Edmonton International Airport",
        "latitude": "53.3097",
        "longitude": "113.5800"
    },
    {
        "airport_name": "Eek",
        "airport_code": "EHU",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Eek Airport",
        "latitude": "43.4225",
        "longitude": "112.0961"
    },
    {
        "airport_name": "El Alamein",
        "airport_code": "DBB",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "El Alamein International Airport",
        "latitude": "30.924444",
        "longitude": "28.461389"
    },
    {
        "airport_name": "El Calafate",
        "airport_code": "FTE",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Comandante Armando Tola International Airport",
        "latitude": "-50.2803",
        "longitude": "-72.0531"
    },
    {
        "airport_name": "Elazig",
        "airport_code": "EZS",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Elazig",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Eldoret",
        "airport_code": "EDL",
        "country_name": "Kenya",
        "country_code": "KE",
        "country_long_code": "KEN",
        "airport_description": "Eldoret International Airport",
        "latitude": "-4.033333",
        "longitude": "39.583333"
    },
    {
        "airport_name": "Elko",
        "airport_code": "EKO",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Elko Regional Airport",
        "latitude": "40.8249",
        "longitude": "-115.792"
    },
    {
        "airport_name": "Elmira",
        "airport_code": "ELM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Elmira/Corning Regional Airport",
        "latitude": "42.1599",
        "longitude": "-76.8916"
    },
    {
        "airport_name": "Enshi",
        "airport_code": "ENH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Enshi Xujiaping Airport",
        "latitude": "30.3203",
        "longitude": "109.485"
    },
    {
        "airport_name": "Entebbe",
        "airport_code": "EBB",
        "country_name": "Uganda",
        "country_code": "UG",
        "country_long_code": "UGA",
        "airport_description": "Entebbe International",
        "latitude": "0.060278",
        "longitude": "32.45"
    },
    {
        "airport_name": "Enugu",
        "airport_code": "ENU",
        "country_name": "Nigeria",
        "country_code": "NG",
        "country_long_code": "NGA",
        "airport_description": "Akanu Ibiam International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Erbil",
        "airport_code": "EBL",
        "country_name": "Iraq",
        "country_code": "IQ",
        "country_long_code": "IRQ",
        "airport_description": "Erbil International Airport ",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Erzincan",
        "airport_code": "ERC",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Erzincan Airport",
        "latitude": "39.7102",
        "longitude": "39.527"
    },
    {
        "airport_name": "Erzurum",
        "airport_code": "ERZ",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Erzurum Airport",
        "latitude": "39.9565",
        "longitude": "41.1702"
    },
    {
        "airport_name": "Escanaba",
        "airport_code": "ESC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Delta County Airport",
        "latitude": "45.7227",
        "longitude": "-87.0937"
    },
    {
        "airport_name": "Esquel",
        "airport_code": "EQS",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Esquel Airport",
        "latitude": "-42.908",
        "longitude": "-71.1394"
    },
    {
        "airport_name": "Eugene",
        "airport_code": "EUG",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Eugene Airport",
        "latitude": "44.12",
        "longitude": "-123.3656"
    },
    {
        "airport_name": "Evansville",
        "airport_code": "EVV",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Evansville Regional Airport",
        "latitude": "38.036944",
        "longitude": "-87.5325"
    },
    {
        "airport_name": "Exeter",
        "airport_code": "EXT",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Exeter Airport",
        "latitude": "50.7344",
        "longitude": "-3.4139"
    },
    {
        "airport_name": "Fairbanks",
        "airport_code": "FAI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Fairbanks International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Faisalabad",
        "airport_code": "LYP",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Faisalabad International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Ferdinand Lumban Tobing",
        "airport_code": "FLZ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Ferdinand Lumban Tobing Airport",
        "latitude": "1.5566",
        "longitude": "98.8901"
    },
    {
        "airport_name": "Fes",
        "airport_code": "FEZ",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Saiss",
        "latitude": "34.033333",
        "longitude": "-4.983333"
    },
    {
        "airport_name": "Figari",
        "airport_code": "FSC",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Sud Corse",
        "latitude": "41.583333",
        "longitude": "9.25"
    },
    {
        "airport_name": "Florence",
        "airport_code": "FLR",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Peretola",
        "latitude": "43.81",
        "longitude": "11.205"
    },
    {
        "airport_name": "Florian\u00f3polis",
        "airport_code": "FLN",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Herc\u00edlio Luz International Airport",
        "latitude": "-27.6703",
        "longitude": "-48.5525"
    },
    {
        "airport_name": "Formosa",
        "airport_code": "FMA",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Formosa International Airport",
        "latitude": "-26.2127",
        "longitude": "-58.2281"
    },
    {
        "airport_name": "Fort Mcmurray",
        "airport_code": "YMM",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Fort Mcmurray Airport",
        "latitude": "56.653333",
        "longitude": "\u00a0-111.221944"
    },
    {
        "airport_name": "Fort Wayne",
        "airport_code": "FWA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Fort Wayne International Airport",
        "latitude": "40.9785",
        "longitude": "-85.1951"
    },
    {
        "airport_name": "Frankfurt",
        "airport_code": "FRA",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Frankfurt International",
        "latitude": "50.026389",
        "longitude": "8.543056"
    },
    {
        "airport_name": "Fredericton",
        "airport_code": "YFC",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Fredericton International Airport",
        "latitude": "45.868889",
        "longitude": "-66.537222"
    },
    {
        "airport_name": "Freetown",
        "airport_code": "FNA",
        "country_name": "Sierra Leone",
        "country_code": "SL",
        "country_long_code": "SLE",
        "airport_description": "Lungi International",
        "latitude": "8.616667",
        "longitude": "-13.2"
    },
    {
        "airport_name": "Friedrichshafen",
        "airport_code": "FDH",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Friedrichshafen Airport",
        "latitude": "47.6713",
        "longitude": "9.5115"
    },
    {
        "airport_name": "Fuerteventura",
        "airport_code": "FUE",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Fuerteventura",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Fukuoka",
        "airport_code": "FUK",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Fukuoka Airport",
        "latitude": "33.583333",
        "longitude": "130.45"
    },
    {
        "airport_name": "Funchal",
        "airport_code": "FNC",
        "country_name": "Portugal",
        "country_code": "PT",
        "country_long_code": "PRT",
        "airport_description": "Cristiano Ronaldo Madeira Int\u2019l Airport",
        "latitude": "32.6979",
        "longitude": "-16.7745"
    },
    {
        "airport_name": "Fuyang",
        "airport_code": "FUG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Fuyang Xiguan Airport",
        "latitude": "32.8822",
        "longitude": "115.734"
    },
    {
        "airport_name": "Fuzhou",
        "airport_code": "FOC",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Fuzhou Changle International",
        "latitude": "26.1",
        "longitude": "119.283333"
    },
    {
        "airport_name": "Gaborone",
        "airport_code": "GBE",
        "country_name": "Botswana",
        "country_code": "BW",
        "country_long_code": "BWA",
        "airport_description": "Sir Seretse Khama International Airport",
        "latitude": "-24.5552",
        "longitude": "25.9182"
    },
    {
        "airport_name": "Gainesville",
        "airport_code": "GNV",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Gainesville Regional Airport",
        "latitude": "29.683333",
        "longitude": "-82.266667"
    },
    {
        "airport_name": "Gambela",
        "airport_code": "GMQ",
        "country_name": "Ethiopia",
        "country_code": "ET",
        "country_long_code": "ETH",
        "airport_description": "Gambela Airport",
        "latitude": "34.418",
        "longitude": "100.13"
    },
    {
        "airport_name": "Ganzhou",
        "airport_code": "KOW",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Ganzhou Huangjin Airport",
        "latitude": "25.8258",
        "longitude": "114.9121"
    },
    {
        "airport_name": "Gassim",
        "airport_code": "ELQ",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Prince Nayef bin Abdulaziz Airport",
        "latitude": "26.3",
        "longitude": "43.816667"
    },
    {
        "airport_name": "Gaya",
        "airport_code": "GAY",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Gaya Airport",
        "latitude": "24.7443",
        "longitude": "84.9512"
    },
    {
        "airport_name": "Gaziantep",
        "airport_code": "GZT",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Oguzeli",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Gazipa\u015fa",
        "airport_code": "GZP",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Gazipa\u015fa-Alanya Airport",
        "latitude": "36.2992",
        "longitude": "32.3006"
    },
    {
        "airport_name": "Gdansk",
        "airport_code": "GDN",
        "country_name": "Poland",
        "country_code": "PL",
        "country_long_code": "POL",
        "airport_description": "Lech Walesa Airport",
        "latitude": "54.3776",
        "longitude": "18.4662"
    },
    {
        "airport_name": "General Lucio Blanco",
        "airport_code": "REX",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Lucio Blanco International Airport",
        "latitude": "26.0089",
        "longitude": "-98.2285"
    },
    {
        "airport_name": "General Santos",
        "airport_code": "GES",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "General Santos International Airport",
        "latitude": "6.0622",
        "longitude": "125.093"
    },
    {
        "airport_name": "Geneva",
        "airport_code": "GVA",
        "country_name": "Switzerland",
        "country_code": "CH",
        "country_long_code": "CHE",
        "airport_description": "Geneva International",
        "latitude": "46.238056",
        "longitude": "6.108889"
    },
    {
        "airport_name": "Genoa",
        "airport_code": "GOA",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Cristoforo Colombo",
        "latitude": "44.43",
        "longitude": "8.8375"
    },
    {
        "airport_name": "George",
        "airport_code": "GRJ",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "George",
        "latitude": "-33.966667",
        "longitude": "22.416667"
    },
    {
        "airport_name": "Georgetown",
        "airport_code": "GEO",
        "country_name": "Guyana",
        "country_code": "GY",
        "country_long_code": "GUY",
        "airport_description": "Cheddi Jagan International Airport",
        "latitude": "6.4986",
        "longitude": "-58.2541"
    },
    {
        "airport_name": "Girona",
        "airport_code": "GRO",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Girona\u2013Costa Brava Airport",
        "latitude": "41.9001",
        "longitude": "2.7606"
    },
    {
        "airport_name": "Gizan",
        "airport_code": "GIZ",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "King Abdullah bin Abdulaziz Airport",
        "latitude": "16.933611",
        "longitude": "42.566944"
    },
    {
        "airport_name": "Glasgow",
        "airport_code": "GLA",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Glasgow International",
        "latitude": "55.8742",
        "longitude": "4.4262"
    },
    {
        "airport_name": "Goa",
        "airport_code": "GOI",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Dabolim",
        "latitude": "15.5",
        "longitude": "73.841667"
    },
    {
        "airport_name": "Golmud",
        "airport_code": "GOQ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Golmud Airport",
        "latitude": "36.4006",
        "longitude": "94.7861"
    },
    {
        "airport_name": "Gorgan",
        "airport_code": "GTO",
        "country_name": "Iran",
        "country_code": "IR",
        "country_long_code": "IRN",
        "airport_description": "Gorgan Airport",
        "latitude": "0.6371",
        "longitude": "122.849"
    },
    {
        "airport_name": "Goteborg",
        "airport_code": "GOT",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Landvetter",
        "latitude": "57.662778",
        "longitude": "12.279722"
    },
    {
        "airport_name": "Gran Canaria",
        "airport_code": "LPA",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Gran Canaria",
        "latitude": "27.931944",
        "longitude": "-15.386667"
    },
    {
        "airport_name": "Granada",
        "airport_code": "GRX",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Federico Garc\u00eda Lorca Granada-Ja\u00e9n Airport",
        "latitude": "37.1887",
        "longitude": "-3.7774"
    },
    {
        "airport_name": "Grand Junction",
        "airport_code": "GJT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Grand Junction Regional Airport",
        "latitude": "39.1224",
        "longitude": "-108.527"
    },
    {
        "airport_name": "Graz",
        "airport_code": "GRZ",
        "country_name": "Austria",
        "country_code": "AT",
        "country_long_code": "AUT",
        "airport_description": "Graz Airport",
        "latitude": "46.9911",
        "longitude": "15.4396"
    },
    {
        "airport_name": "Great Falls",
        "airport_code": "GTF",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Great Falls International Airport",
        "latitude": "47.482",
        "longitude": "-111.3701"
    },
    {
        "airport_name": "Guadalajara",
        "airport_code": "GDL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Guadalajara International Airport",
        "latitude": "21.454722",
        "longitude": "-103.301111"
    },
    {
        "airport_name": "Guangyuan",
        "airport_code": "GYS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Guangyuan Panlong Airport",
        "latitude": "32.3911",
        "longitude": "105.6997"
    },
    {
        "airport_name": "Guangzhou",
        "airport_code": "CAN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Baiyun International",
        "latitude": "23.3925",
        "longitude": "113.298889"
    },
    {
        "airport_name": "Guayaquil",
        "airport_code": "GYE",
        "country_name": "Ecuador",
        "country_code": "EC",
        "country_long_code": "ECU",
        "airport_description": "Jos\u00e9 Joaqu\u00edn de Olmedo International Airport",
        "latitude": "-2.1574",
        "longitude": "-79.8836"
    },
    {
        "airport_name": "Guilin",
        "airport_code": "KWL",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Guilin Liangjiang International Airport",
        "latitude": "25.2181",
        "longitude": "110.0392"
    },
    {
        "airport_name": "Guiyang",
        "airport_code": "KWE",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Guiyang Longdongbao International Airport",
        "latitude": "26.5385",
        "longitude": "106.8007"
    },
    {
        "airport_name": "Gunungsitoli",
        "airport_code": "GNS",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Binaka Airport",
        "latitude": "1.1664",
        "longitude": "97.7047"
    },
    {
        "airport_name": "Gurayat",
        "airport_code": "URY",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Gurayat",
        "latitude": "31.333333",
        "longitude": "37.416667"
    },
    {
        "airport_name": "Guwahati",
        "airport_code": "GAU",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Lokpriya Gopinath Bordoloi International Airport",
        "latitude": "26.1061",
        "longitude": "91.5859"
    },
    {
        "airport_name": "Guyuan",
        "airport_code": "GYU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Guyuan Liupanshan Airport",
        "latitude": "36.078",
        "longitude": "106.216"
    },
    {
        "airport_name": "Gwadar",
        "airport_code": "GWD",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Gwadar International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Hai Phong",
        "airport_code": "HPH",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Cat Bi International Airport",
        "latitude": "20.8168",
        "longitude": "106.7246"
    },
    {
        "airport_name": "Haidong",
        "airport_code": "XNN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xining Caojiabao",
        "latitude": "36.549722",
        "longitude": "101.75"
    },
    {
        "airport_name": "Haikou",
        "airport_code": "HAK",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Haikou Meilan International",
        "latitude": "19.983333",
        "longitude": "110.033333"
    },
    {
        "airport_name": "Hail",
        "airport_code": "HAS",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Hail Airport",
        "latitude": "27.516667",
        "longitude": "41.75"
    },
    {
        "airport_name": "Hailar",
        "airport_code": "HIA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hulunbuir Hailar Airport",
        "latitude": "33.7908",
        "longitude": "119.1253"
    },
    {
        "airport_name": "Hailey",
        "airport_code": "SUN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Friedman Memorial Airport",
        "latitude": "43.5047",
        "longitude": "-114.2956"
    },
    {
        "airport_name": "Halifax",
        "airport_code": "YHZ",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Stanfield International Airport",
        "latitude": "44.8808",
        "longitude": "63.5085"
    },
    {
        "airport_name": "Halmstad",
        "airport_code": "HAD",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Halmstad City Airport",
        "latitude": "56.6911",
        "longitude": "12.8202"
    },
    {
        "airport_name": "Hambantota",
        "airport_code": "HMB",
        "country_name": "Sri Lanka",
        "country_code": "LK",
        "country_long_code": "LKA",
        "airport_description": "Mattala Rajapaksa International Airport",
        "latitude": "26.3428",
        "longitude": "31.7364"
    },
    {
        "airport_name": "Hamburg",
        "airport_code": "HAM",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Hamburg",
        "latitude": "53.633333",
        "longitude": "9.983333"
    },
    {
        "airport_name": "Hamilton",
        "airport_code": "HTT",
        "country_name": "New Zealand",
        "country_code": "NZ",
        "country_long_code": "NZL",
        "airport_description": "Hamilton Airport",
        "latitude": "38.2066",
        "longitude": "90.8372"
    },
    {
        "airport_name": "Handan",
        "airport_code": "HDG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Handan Airport",
        "latitude": "36.524",
        "longitude": "114.425"
    },
    {
        "airport_name": "Hangzhou",
        "airport_code": "HGH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hangzhou Xiaoshan International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Hannover",
        "airport_code": "HAJ",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Hannover",
        "latitude": "52.461111",
        "longitude": "9.685"
    },
    {
        "airport_name": "Hanoi",
        "airport_code": "HAN",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Noi Bai International Airport",
        "latitude": "21.221111",
        "longitude": "105.807222"
    },
    {
        "airport_name": "Harare",
        "airport_code": "HRE",
        "country_name": "Zimbabwe",
        "country_code": "ZW",
        "country_long_code": "ZWE",
        "airport_description": "Rg Mugabe International",
        "latitude": "-17.931944",
        "longitude": "31.092778"
    },
    {
        "airport_name": "Harbin",
        "airport_code": "HRB",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Harbin Taiping International Airport",
        "latitude": "31.143333",
        "longitude": "121.805278"
    },
    {
        "airport_name": "Hargeisa",
        "airport_code": "HGA",
        "country_name": "Somalia",
        "country_code": "SO",
        "country_long_code": "SOM",
        "airport_description": "Hargeisa International Airport",
        "latitude": "9.483333",
        "longitude": "44.1"
    },
    {
        "airport_name": "Harrisburg",
        "airport_code": "MDT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Harrisburg International Airport",
        "latitude": "40.1935",
        "longitude": "-76.7634"
    },
    {
        "airport_name": "Hat Yai",
        "airport_code": "HDY",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Hat Yai International Airport",
        "latitude": "6.9332",
        "longitude": "100.3933"
    },
    {
        "airport_name": "Hatay",
        "airport_code": "HTY",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Hatay",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Haugesund",
        "airport_code": "HAU",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Haugesund Airport, Karm\u00f8y",
        "latitude": "59.3453",
        "longitude": "5.2084"
    },
    {
        "airport_name": "Havana",
        "airport_code": "HAV",
        "country_name": "Cuba",
        "country_code": "CU",
        "country_long_code": "CUB",
        "airport_description": "Jos\u00e9 Mart\u00ed International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Hebei",
        "airport_code": "HBQ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hebei Airport",
        "latitude": "19.1382",
        "longitude": "110.4548"
    },
    {
        "airport_name": "Hebron",
        "airport_code": "CVG",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Cincinnati/Northern Kentucky International Airport",
        "latitude": "39.048889",
        "longitude": "-84.667778"
    },
    {
        "airport_name": "Hefei",
        "airport_code": "HFE",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hefei Xinqiao International Airport",
        "latitude": "31.78",
        "longitude": "117.297"
    },
    {
        "airport_name": "Heihe",
        "airport_code": "HEK",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Heihe Airport",
        "latitude": "50.17",
        "longitude": "127.308"
    },
    {
        "airport_name": "Helena",
        "airport_code": "HLN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Helena Regional Airport",
        "latitude": "46.6068",
        "longitude": "-111.9831"
    },
    {
        "airport_name": "Helsinki",
        "airport_code": "HEL",
        "country_name": "Finland",
        "country_code": "FI",
        "country_long_code": "FIN",
        "airport_description": "Helsinki Vantaa",
        "latitude": "60.317222",
        "longitude": "24.963333"
    },
    {
        "airport_name": "Hengyang",
        "airport_code": "HNY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hengyang Nanyue Airport",
        "latitude": "26.7417",
        "longitude": "112.627"
    },
    {
        "airport_name": "Heraklion",
        "airport_code": "HER",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Heraklion International Airport",
        "latitude": "35.339722",
        "longitude": "25.180278"
    },
    {
        "airport_name": "Hermosillo",
        "airport_code": "HMO",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Ignacio Pesqueira Garc\u00eda International Airport",
        "latitude": "29.0959",
        "longitude": "-111.0472"
    },
    {
        "airport_name": "Heze",
        "airport_code": "HZG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Heze Mudan Airport",
        "latitude": "33.0636",
        "longitude": "107.0086"
    },
    {
        "airport_name": "Hibbing",
        "airport_code": "HIB",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Hibbing Range Regional Airport",
        "latitude": "47.3866",
        "longitude": "-92.838"
    },
    {
        "airport_name": "Hilton Head Island",
        "airport_code": "HHH",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Hilton Head Airport",
        "latitude": "32.2244",
        "longitude": "-80.6975"
    },
    {
        "airport_name": "Hiroshima",
        "airport_code": "HIJ",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Hiroshima Airport",
        "latitude": "34.4361",
        "longitude": "132.9194"
    },
    {
        "airport_name": "Ho Chi Minh City",
        "airport_code": "SGN",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Tan Son Nhat International Airport",
        "latitude": "10.818889",
        "longitude": "106.651944"
    },
    {
        "airport_name": "Hofuf",
        "airport_code": "HOF",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Al-Ahsa",
        "latitude": "25.285278",
        "longitude": "49.485278"
    },
    {
        "airport_name": "Hohhot",
        "airport_code": "HET",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hohhot Baita International Airport",
        "latitude": "40.8514",
        "longitude": "111.8252"
    },
    {
        "airport_name": "Hohhot",
        "airport_code": "HLD",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hohhot Baita International Airport",
        "latitude": "49.205",
        "longitude": "119.824"
    },
    {
        "airport_name": "Hong Kong",
        "airport_code": "HKG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hong Kong International",
        "latitude": "22.308889",
        "longitude": "113.914722"
    },
    {
        "airport_name": "Honolulu",
        "airport_code": "HNL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Honolulu International Airport",
        "latitude": "21.333333",
        "longitude": "-157.933333"
    },
    {
        "airport_name": "Hotan",
        "airport_code": "HTN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Hotan Airport",
        "latitude": "37.0385",
        "longitude": "79.8649"
    },
    {
        "airport_name": "Houston",
        "airport_code": "HOU",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "William P. Hobby Airport",
        "latitude": "29.645556",
        "longitude": "-95.278889"
    },
    {
        "airport_name": "Huangyan",
        "airport_code": "HYN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Taizhou Luqiao Airport",
        "latitude": "28.5622",
        "longitude": "121.4294"
    },
    {
        "airport_name": "Huatulco",
        "airport_code": "HUX",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Bah\u00edas de Huatulco International Airport",
        "latitude": "15.7753",
        "longitude": "-96.2626"
    },
    {
        "airport_name": "Hue",
        "airport_code": "HUI",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Phu Bai International Airport",
        "latitude": "16.399",
        "longitude": "107.7037"
    },
    {
        "airport_name": "Huizhou",
        "airport_code": "HZA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Huizhou Pingtan Airport",
        "latitude": "35.0344",
        "longitude": "115.8835"
    },
    {
        "airport_name": "Huizhou",
        "airport_code": "HUZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Huizhou Pingtan Airport",
        "latitude": "23.0486",
        "longitude": "114.5996"
    },
    {
        "airport_name": "Humberside",
        "airport_code": "HUY",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Humberside Airport",
        "latitude": "53.5744",
        "longitude": "-0.3508"
    },
    {
        "airport_name": "Huntsville",
        "airport_code": "HSV",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Huntsville International Airport",
        "latitude": "34.637222",
        "longitude": "-86.775"
    },
    {
        "airport_name": "Hurghada",
        "airport_code": "HRG",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Hurghada International Airport",
        "latitude": "27.18",
        "longitude": "33.796"
    },
    {
        "airport_name": "Hyderabad",
        "airport_code": "HYD",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Rajiv Gandhi International",
        "latitude": "17.453056",
        "longitude": "78.4675"
    },
    {
        "airport_name": "Ia\u0219i",
        "airport_code": "IAS",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Ia\u0219i International Airport",
        "latitude": "47.1785",
        "longitude": "27.6206"
    },
    {
        "airport_name": "Ibiza",
        "airport_code": "IBZ",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Ibiza",
        "latitude": "38.8748635",
        "longitude": "1.3686483"
    },
    {
        "airport_name": "Igdir",
        "airport_code": "IGD",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "I\u011fd\u0131r Airport",
        "latitude": "39.9766",
        "longitude": "43.8766"
    },
    {
        "airport_name": "Iloilo",
        "airport_code": "ILO",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Iloilo International Airport",
        "latitude": "10.713056",
        "longitude": "122.545278"
    },
    {
        "airport_name": "Imphal",
        "airport_code": "IMF",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Imphal Airport",
        "latitude": "24.76",
        "longitude": "93.8967"
    },
    {
        "airport_name": "Indianapolis",
        "airport_code": "IND",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Indianapolis International Airport",
        "latitude": "39.717222",
        "longitude": "-86.294722"
    },
    {
        "airport_name": "Indore",
        "airport_code": "IDR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Devi Ahilya Bai Holkar",
        "latitude": "22.716667",
        "longitude": "75.8"
    },
    {
        "airport_name": "International Falls",
        "airport_code": "INL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Falls International Airport",
        "latitude": "48.5662",
        "longitude": "-93.4031"
    },
    {
        "airport_name": "Inverness",
        "airport_code": "INV",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Inverness Airport",
        "latitude": "57.5425",
        "longitude": "-4.0475"
    },
    {
        "airport_name": "Ioannina",
        "airport_code": "IOA",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Ioannina National Airport",
        "latitude": "39.6964",
        "longitude": "20.8225"
    },
    {
        "airport_name": "Iron Mountain",
        "airport_code": "IMT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Ford Airport",
        "latitude": "45.8184",
        "longitude": "-88.1145"
    },
    {
        "airport_name": "Islamabad",
        "airport_code": "ISB",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Islamabad International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "island of Tenerife",
        "airport_code": "TFN",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Tenerife North Airport",
        "latitude": "28.482778",
        "longitude": "-16.341667"
    },
    {
        "airport_name": "Isparta",
        "airport_code": "ISE",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Isparta S\u00fcleyman Demirel Airport",
        "latitude": "37.8554",
        "longitude": "30.3684"
    },
    {
        "airport_name": "Istanbul",
        "airport_code": "IST",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Istanbul Airport",
        "latitude": "40.976944",
        "longitude": "28.821111"
    },
    {
        "airport_name": "Ithaca",
        "airport_code": "ITH",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Ithaca Tompkins Regional Airport",
        "latitude": "42.491",
        "longitude": "-76.4584"
    },
    {
        "airport_name": "Ixtapa-Zihuatanejo",
        "airport_code": "ZIH",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Ixtapa-Zihuatanejo International Airport",
        "latitude": "17.6016",
        "longitude": "-101.4605"
    },
    {
        "airport_name": "Izmir",
        "airport_code": "ADB",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Izmir Adnan Menderes Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Jackson",
        "airport_code": "JAC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Jackson Hole Airport",
        "latitude": "43.6",
        "longitude": "-110.733333"
    },
    {
        "airport_name": "Jackson",
        "airport_code": "JAN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Jackson\u2013Medgar Wiley Evers International Airport",
        "latitude": "32.3112",
        "longitude": "-90.0759"
    },
    {
        "airport_name": "Jacksonville",
        "airport_code": "JAX",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Jacksonville International",
        "latitude": "30.416667",
        "longitude": "-81.633333"
    },
    {
        "airport_name": "Jacksonville",
        "airport_code": "OAJ",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Albert J. Ellis Airport",
        "latitude": "34.8292",
        "longitude": "-77.6121"
    },
    {
        "airport_name": "Jaipur",
        "airport_code": "JAI",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "International",
        "latitude": "26.816667",
        "longitude": "75.8"
    },
    {
        "airport_name": "Jakarta",
        "airport_code": "CGK",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Soekarno Hatta International",
        "latitude": "-6.125556",
        "longitude": "106.655833"
    },
    {
        "airport_name": "Jakarta",
        "airport_code": "HLP",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Halim Perdanakusuma International Airport",
        "latitude": "-6.2666",
        "longitude": "106.89"
    },
    {
        "airport_name": "Jambi",
        "airport_code": "DJB",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sultan Thaha Airport",
        "latitude": "-1.638",
        "longitude": "103.6431"
    },
    {
        "airport_name": "Jammu",
        "airport_code": "IXJ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Jammu Airport",
        "latitude": "32.6891",
        "longitude": "74.8374"
    },
    {
        "airport_name": "Jamnagar",
        "airport_code": "JGA",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Jamnagar Airport",
        "latitude": "22.4655",
        "longitude": "70.011"
    },
    {
        "airport_name": "Jayapura",
        "airport_code": "DJJ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sentani International Airport",
        "latitude": "-2.5769",
        "longitude": "140.5164"
    },
    {
        "airport_name": "Jeddah",
        "airport_code": "JED",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "King Abdulaziz International",
        "latitude": "21.660503",
        "longitude": "39.179022"
    },
    {
        "airport_name": "Jeju",
        "airport_code": "CJU",
        "country_name": "South Korea",
        "country_code": "KR",
        "country_long_code": "KOR",
        "airport_description": "Jeju International Airport",
        "latitude": "33.5113",
        "longitude": "126.492"
    },
    {
        "airport_name": "Jember",
        "airport_code": "JBB",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Notohadinegoro Airport",
        "latitude": "-8.5405",
        "longitude": "114.144"
    },
    {
        "airport_name": "Jerez De Le Fron",
        "airport_code": "XRY",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Jerez Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Jessore",
        "airport_code": "JSR",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Jessore",
        "latitude": "23.183333",
        "longitude": "89.166667"
    },
    {
        "airport_name": "Jiamusi",
        "airport_code": "JMU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jiamusi Dongjiao Airport",
        "latitude": "46.8434",
        "longitude": "130.4647"
    },
    {
        "airport_name": "Ji'an",
        "airport_code": "JGS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jinggangshan Airport",
        "latitude": "27.1095",
        "longitude": "114.9726"
    },
    {
        "airport_name": "Jiayuguan",
        "airport_code": "JGD",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jiayuguan Airport",
        "latitude": "50.3743",
        "longitude": "124.1189"
    },
    {
        "airport_name": "Jinan",
        "airport_code": "TNA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jinan Yaoqiang International",
        "latitude": "36.75",
        "longitude": "116.966667"
    },
    {
        "airport_name": "Jinchang",
        "airport_code": "JIC",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jinchang Jinchuan Airport",
        "latitude": "38.5422",
        "longitude": "102.3482"
    },
    {
        "airport_name": "Jingdezhen",
        "airport_code": "JDZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jingdezhen Luojia Airport",
        "latitude": "29.3386",
        "longitude": "117.1767"
    },
    {
        "airport_name": "Jinghong",
        "airport_code": "JHG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xishuangbanna Gasa Airport",
        "latitude": "21.9739",
        "longitude": "100.76"
    },
    {
        "airport_name": "Jinhua",
        "airport_code": "YIW",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yiwu",
        "latitude": "29.266667",
        "longitude": "120.05"
    },
    {
        "airport_name": "Jinzhou",
        "airport_code": "JNZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jinzhou Bay Airport",
        "latitude": "41.1014",
        "longitude": "121.061"
    },
    {
        "airport_name": "Jiqing",
        "airport_code": "JIQ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jiqing Airport",
        "latitude": "29.5133",
        "longitude": "108.7741"
    },
    {
        "airport_name": "Jodhpur",
        "airport_code": "JDH",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Jodhpur",
        "latitude": "26.25",
        "longitude": "73.05"
    },
    {
        "airport_name": "Johannesburg",
        "airport_code": "JNB",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "O.R. Tambo International",
        "latitude": "-26.139167",
        "longitude": "28.246111"
    },
    {
        "airport_name": "Johor Bahru",
        "airport_code": "JHB",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Senai International Airport",
        "latitude": "1.45",
        "longitude": "103.75"
    },
    {
        "airport_name": "Jouf",
        "airport_code": "AJF",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Jouf",
        "latitude": "29.933333",
        "longitude": "40.2"
    },
    {
        "airport_name": "Juba",
        "airport_code": "JUB",
        "country_name": "Sudan",
        "country_code": "SD",
        "country_long_code": "SDN",
        "airport_description": "Juba International Airport",
        "latitude": "4.871944",
        "longitude": "31.601111"
    },
    {
        "airport_name": "Juneau",
        "airport_code": "JNU",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Juneau International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Kahramanmaras",
        "airport_code": "KCM",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Kahramanmaras",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Kahului",
        "airport_code": "OGG",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Kahului Airport",
        "latitude": "20.898611",
        "longitude": "-156.430556"
    },
    {
        "airport_name": "Kailua",
        "airport_code": "KOA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Kona International Airport",
        "latitude": "19.738889",
        "longitude": "-156.045556"
    },
    {
        "airport_name": "Kalamata",
        "airport_code": "KLX",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Kalamata International Airport",
        "latitude": "37.068333",
        "longitude": "22.025556"
    },
    {
        "airport_name": "Kalamazoo",
        "airport_code": "AZO",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Kalamazoo/Battle Creek International Airport",
        "latitude": "42.2349",
        "longitude": "-85.5521"
    },
    {
        "airport_name": "Kalibo",
        "airport_code": "KLO",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Kalibo International Airport",
        "latitude": "11.6794",
        "longitude": "122.376"
    },
    {
        "airport_name": "Kalispell",
        "airport_code": "FCA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Glacier Park International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Kalmar",
        "airport_code": "KLR",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Kalmar Airport",
        "latitude": "56.6855",
        "longitude": "16.2876"
    },
    {
        "airport_name": "Kano",
        "airport_code": "KAN",
        "country_name": "Nigeria",
        "country_code": "NG",
        "country_long_code": "NGA",
        "airport_description": "Mallam Aminu Kano International",
        "latitude": "12.0475",
        "longitude": "8.524722"
    },
    {
        "airport_name": "Kansas City",
        "airport_code": "MKC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Charles B. Wheeler Downtown Airport",
        "latitude": "39.116667",
        "longitude": "-94.583333"
    },
    {
        "airport_name": "Kansas City",
        "airport_code": "MCI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Kansas City International Airport",
        "latitude": "39.2976",
        "longitude": "-94.7139"
    },
    {
        "airport_name": "Kaohsiung",
        "airport_code": "KHH",
        "country_name": "Taiwan",
        "country_code": "TW",
        "country_long_code": "TWN",
        "airport_description": "Kaohsiung International Airport",
        "latitude": "22.5769",
        "longitude": "120.35"
    },
    {
        "airport_name": "Karachi",
        "airport_code": "KHI",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Jinnah International",
        "latitude": "24.906667",
        "longitude": "67.160833"
    },
    {
        "airport_name": "Karamay",
        "airport_code": "KRY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Karamay Airport",
        "latitude": "45.4666",
        "longitude": "84.9528"
    },
    {
        "airport_name": "Karlsruhe",
        "airport_code": "FKB",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Karlsruhe/Baden-Baden Airport",
        "latitude": "48.7794",
        "longitude": "8.0805"
    },
    {
        "airport_name": "Kars",
        "airport_code": "KSY",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Kars",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Kashi",
        "airport_code": "KHG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Kashgar Airport",
        "latitude": "39.5429",
        "longitude": "76.0193"
    },
    {
        "airport_name": "Kastamonu",
        "airport_code": "KFS",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Kastamonu",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Kathmandu",
        "airport_code": "KTM",
        "country_name": "Nepal",
        "country_code": "NP",
        "country_long_code": "NPL",
        "airport_description": "Tribhuvan International",
        "latitude": "27.696667",
        "longitude": "85.359167"
    },
    {
        "airport_name": "Kavala",
        "airport_code": "KVA",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Kavala International Airport ",
        "latitude": "40.9133",
        "longitude": "24.6192"
    },
    {
        "airport_name": "Kayseri",
        "airport_code": "ASR",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Erkilet",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Kazan",
        "airport_code": "KZN",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Kazan International",
        "latitude": "55.8",
        "longitude": "49"
    },
    {
        "airport_name": "Kefalonia",
        "airport_code": "EFL",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Kefalonia Island International Airport",
        "latitude": "38.1201",
        "longitude": "20.5005"
    },
    {
        "airport_name": "Kelowna",
        "airport_code": "YLW",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Kelowna International Airport",
        "latitude": "49.9561",
        "longitude": "-119.377"
    },
    {
        "airport_name": "Kendari",
        "airport_code": "KDI",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Haluoleo Airport",
        "latitude": "-4.0816",
        "longitude": "122.4175"
    },
    {
        "airport_name": "Kerkyra",
        "airport_code": "CFU",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Corfu International Airport",
        "latitude": "39.601389",
        "longitude": "19.901944"
    },
    {
        "airport_name": "Khajuraho",
        "airport_code": "HJR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Khajuraho Airport",
        "latitude": "24.8172",
        "longitude": "79.9186"
    },
    {
        "airport_name": "Kharkiv",
        "airport_code": "HRK",
        "country_name": "Ukraine",
        "country_code": "UA",
        "country_long_code": "UKR",
        "airport_description": "Kharkiv International Airport",
        "latitude": "49.9248",
        "longitude": "36.29"
    },
    {
        "airport_name": "Khartoum",
        "airport_code": "KRT",
        "country_name": "Sudan",
        "country_code": "SD",
        "country_long_code": "SDN",
        "airport_description": "International",
        "latitude": "15.589444",
        "longitude": "32.553056"
    },
    {
        "airport_name": "Kherson",
        "airport_code": "KHE",
        "country_name": "Ukraine",
        "country_code": "UA",
        "country_long_code": "UKR",
        "airport_description": "Kherson International Airport",
        "latitude": "46.6758",
        "longitude": "32.5064"
    },
    {
        "airport_name": "Kigali",
        "airport_code": "KGL",
        "country_name": "Rwanda",
        "country_code": "RW",
        "country_long_code": "RWA",
        "airport_description": "Kigali International Airport",
        "latitude": "-1.968611",
        "longitude": "30.139444"
    },
    {
        "airport_name": "Kimberley",
        "airport_code": "KIM",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Kimberley",
        "latitude": "-28.8",
        "longitude": "24.766667"
    },
    {
        "airport_name": "Kincheloe",
        "airport_code": "CIU",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Chippewa County International Airport",
        "latitude": "46.2508",
        "longitude": "-84.4724"
    },
    {
        "airport_name": "Kingstown",
        "airport_code": "SVD",
        "country_name": "Saint Vincent",
        "country_code": "VC",
        "country_long_code": "VCT",
        "airport_description": "Argyle International Airport",
        "latitude": "13.1443",
        "longitude": "-61.2109"
    },
    {
        "airport_name": "Kinshasa",
        "airport_code": "FIH",
        "country_name": "Congo Brazzaville",
        "country_code": "CG",
        "country_long_code": "",
        "airport_description": "N'Djili International",
        "latitude": "-4.385833",
        "longitude": "15.444444"
    },
    {
        "airport_name": "Kirkenes",
        "airport_code": "KKN",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Kirkenes Airport, H\u00f8ybuktmoen",
        "latitude": "69.7258",
        "longitude": "29.8913"
    },
    {
        "airport_name": "Kiruna",
        "airport_code": "KRN",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Kiruna Airport",
        "latitude": "67.8218",
        "longitude": "20.3368"
    },
    {
        "airport_name": "Kisumu",
        "airport_code": "KIS",
        "country_name": "Kenya",
        "country_code": "KE",
        "country_long_code": "KEN",
        "airport_description": "Kisumu Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Knoxville",
        "airport_code": "TYS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "McGhee Tyson Airport",
        "latitude": "35.95",
        "longitude": "-83.916667"
    },
    {
        "airport_name": "Kobe",
        "airport_code": "UKB",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Kobe Airport",
        "latitude": "34.6328",
        "longitude": "135.2239"
    },
    {
        "airport_name": "Kochi",
        "airport_code": "COK",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Kochi International",
        "latitude": "10.151944",
        "longitude": "76.401944"
    },
    {
        "airport_name": "Kolkata",
        "airport_code": "CCU",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Subhas Chandra Bose",
        "latitude": "22.633333",
        "longitude": "88.433333"
    },
    {
        "airport_name": "Konya",
        "airport_code": "KYA",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Konya",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Korla",
        "airport_code": "KRL",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Korla Airport",
        "latitude": "41.6978",
        "longitude": "86.1289"
    },
    {
        "airport_name": "Koror",
        "airport_code": "ROR",
        "country_name": "Palau Islands",
        "country_code": "PW",
        "country_long_code": "PLW",
        "airport_description": "Roman Tmetuchl International Airport",
        "latitude": "7.3673",
        "longitude": "134.5442"
    },
    {
        "airport_name": "Kos",
        "airport_code": "KGS",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Kos Airport",
        "latitude": "36.793333",
        "longitude": "36.793333"
    },
    {
        "airport_name": "Kos",
        "airport_code": "KSC",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Kos Island International Airport",
        "latitude": "48.6631",
        "longitude": "21.2411"
    },
    {
        "airport_name": "Kota Baharu",
        "airport_code": "KBR",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Sultan Ismail Petra Airport",
        "latitude": "6.166944",
        "longitude": "102.293056"
    },
    {
        "airport_name": "Kota Kinabalu",
        "airport_code": "BKI",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Kota Kinabalu International Airport",
        "latitude": "5.937222",
        "longitude": "116.05"
    },
    {
        "airport_name": "Kozhikode",
        "airport_code": "CCJ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Kozhikode International Airport",
        "latitude": "11.136944",
        "longitude": "75.955278"
    },
    {
        "airport_name": "Krabi",
        "airport_code": "KBV",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Krabi International Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Krakow",
        "airport_code": "KRK",
        "country_name": "Poland",
        "country_code": "PL",
        "country_long_code": "POL",
        "airport_description": "John Paul II International Airport",
        "latitude": "50.07617",
        "longitude": "19.79157"
    },
    {
        "airport_name": "Krasnodar",
        "airport_code": "KRR",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Krasnodar International Airport",
        "latitude": "45.0347",
        "longitude": "39.1705"
    },
    {
        "airport_name": "Kristiansand",
        "airport_code": "KRS",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Kristiansand Airport, Kjevik",
        "latitude": "58.2042",
        "longitude": "8.0854"
    },
    {
        "airport_name": "Kristiansund",
        "airport_code": "KSU",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Kristiansund Airport, Kvernberget",
        "latitude": "63.1118",
        "longitude": "7.8245"
    },
    {
        "airport_name": "Kuala Lumpur",
        "airport_code": "KUL",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Kuala Lumpur International Airport",
        "latitude": "2.745556",
        "longitude": "101.71"
    },
    {
        "airport_name": "Kuala Terengganu",
        "airport_code": "TGG",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Sultan Mahmud Airport",
        "latitude": "5.386111",
        "longitude": "103.107778"
    },
    {
        "airport_name": "Kuantan",
        "airport_code": "KUA",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Kuantan Sultan Ahmad Shah Airport",
        "latitude": "3.766667",
        "longitude": "103.2"
    },
    {
        "airport_name": "Kuching",
        "airport_code": "KCH",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Kuching International Airport",
        "latitude": "1.484722",
        "longitude": "110.346944"
    },
    {
        "airport_name": "Kumamoto",
        "airport_code": "KMJ",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Kumamoto Airport",
        "latitude": "32.8373",
        "longitude": "130.855"
    },
    {
        "airport_name": "Kunming",
        "airport_code": "KMG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Kunming Changshui International",
        "latitude": "24.9925",
        "longitude": "102.743611"
    },
    {
        "airport_name": "Kupang",
        "airport_code": "KOE",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "El Tari Airport",
        "latitude": "-10.1716",
        "longitude": "123.6712"
    },
    {
        "airport_name": "Kuqa",
        "airport_code": "KCA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Kuqa Qiuci Airport",
        "latitude": "41.7181",
        "longitude": "82.9869"
    },
    {
        "airport_name": "Kutahya",
        "airport_code": "KZR",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Zafer Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Kuwait",
        "airport_code": "KWI",
        "country_name": "Kuwait",
        "country_code": "KW",
        "country_long_code": "KWT",
        "airport_description": "Kuwait International",
        "latitude": "29.226667",
        "longitude": "47.968889"
    },
    {
        "airport_name": "Kyiv",
        "airport_code": "IEV",
        "country_name": "Ukraine",
        "country_code": "UA",
        "country_long_code": "UKR",
        "airport_description": "Igor Sikorsky Kyiv International Airport",
        "latitude": "50.4017",
        "longitude": "30.4497"
    },
    {
        "airport_name": "La Gomera",
        "airport_code": "GMZ",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "La Gomera Airport",
        "latitude": "28.0296",
        "longitude": "-17.2146"
    },
    {
        "airport_name": "La Paz",
        "airport_code": "LAP",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Manuel M\u00e1rquez de Le\u00f3n Intl Airport",
        "latitude": "24.0727",
        "longitude": "-110.3617"
    },
    {
        "airport_name": "La Rioja",
        "airport_code": "IRJ",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Capit\u00e1n Vicente Almandos Almonacid Airport",
        "latitude": "-29.3816",
        "longitude": "-66.7958"
    },
    {
        "airport_name": "Laayoune",
        "airport_code": "EUN",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Hassan I",
        "latitude": "27.15",
        "longitude": "-13.2"
    },
    {
        "airport_name": "Labuan",
        "airport_code": "LBU",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Labuan Airport",
        "latitude": "5.3",
        "longitude": "115.25"
    },
    {
        "airport_name": "Labuan Bajo",
        "airport_code": "LBJ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Komodo Airport",
        "latitude": "-8.4867",
        "longitude": "119.8896"
    },
    {
        "airport_name": "Lafayette",
        "airport_code": "LFT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Lafayette Regional Airport",
        "latitude": "30.2053",
        "longitude": "-91.9876"
    },
    {
        "airport_name": "Lagos",
        "airport_code": "LOS",
        "country_name": "Nigeria",
        "country_code": "NG",
        "country_long_code": "NGA",
        "airport_description": "Murtala Muhammed International",
        "latitude": "6.5775",
        "longitude": "3.321111"
    },
    {
        "airport_name": "Lahore",
        "airport_code": "LHE",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Allama Iqbal International",
        "latitude": "31.521667",
        "longitude": "74.403611"
    },
    {
        "airport_name": "Lamezia Terme",
        "airport_code": "SUF",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Lamezia Terme",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Lampedusa",
        "airport_code": "LMP",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Lampedusa Airport",
        "latitude": "35.4979",
        "longitude": "12.6181"
    },
    {
        "airport_name": "Langkawi",
        "airport_code": "LGK",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Langkawi International Airport",
        "latitude": "6.329722",
        "longitude": "99.728611"
    },
    {
        "airport_name": "Lansing",
        "airport_code": "LAN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Capital Region International Airport",
        "latitude": "42.7787",
        "longitude": "-84.5874"
    },
    {
        "airport_name": "Lanzarote",
        "airport_code": "ACE",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Lanzarote",
        "latitude": "28.945556",
        "longitude": "-13.605278"
    },
    {
        "airport_name": "Lanzhou",
        "airport_code": "LHW",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Lanzhou Zhongchuan International",
        "latitude": "36.016667",
        "longitude": "103.75"
    },
    {
        "airport_name": "Laoag",
        "airport_code": "LAO",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Laoag International Airport",
        "latitude": "18.183333",
        "longitude": "120.533333"
    },
    {
        "airport_name": "Lapu-Lapu",
        "airport_code": "CEB",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Mactan-Cebu International Airport",
        "latitude": "10.3075",
        "longitude": "125.979444"
    },
    {
        "airport_name": "Larnaca",
        "airport_code": "LCA",
        "country_name": "Cyprus",
        "country_code": "CY",
        "country_long_code": "CYP",
        "airport_description": "Larnaca",
        "latitude": "34.875",
        "longitude": "33.624722"
    },
    {
        "airport_name": "Las Vegas",
        "airport_code": "LAS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "McCarran International",
        "latitude": "36.083333",
        "longitude": "-115.166667"
    },
    {
        "airport_name": "Leeds/Bradford",
        "airport_code": "LBA",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Leeds Bradford Airport",
        "latitude": "53.8659",
        "longitude": "-1.6606"
    },
    {
        "airport_name": "Leh",
        "airport_code": "IXL",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Kushok Bakula Rimpoche",
        "latitude": "34.166667",
        "longitude": "77.583333"
    },
    {
        "airport_name": "Leipzig ",
        "airport_code": "LEJ",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Leipzig Halle Airport",
        "latitude": "51.4325",
        "longitude": "12.241667"
    },
    {
        "airport_name": "Lemnos",
        "airport_code": "LXS",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Lemnos International Airport ",
        "latitude": "39.9171",
        "longitude": "25.2363"
    },
    {
        "airport_name": "Le\u00f3n/Del Baj\u00edo",
        "airport_code": "BJX",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Del Baj\u00edo International Airport",
        "latitude": "20.9935",
        "longitude": "-101.481"
    },
    {
        "airport_name": "Lewiston",
        "airport_code": "LWS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Lewiston\u2013Nez Perce County Airport",
        "latitude": "46.3745",
        "longitude": "-117.0156"
    },
    {
        "airport_name": "Lhasa",
        "airport_code": "LXA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Lhasa Gonggar",
        "latitude": "29.293056",
        "longitude": "90.900278"
    },
    {
        "airport_name": "Lhokseumawe",
        "airport_code": "LSW",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Malikus Saleh Airport",
        "latitude": "5.2267",
        "longitude": "96.9503"
    },
    {
        "airport_name": "Lianyungang",
        "airport_code": "LYG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Lianyungang Baitabu Airport",
        "latitude": "34.5717",
        "longitude": "118.873"
    },
    {
        "airport_name": "Libreville",
        "airport_code": "LBV",
        "country_name": "Gabon",
        "country_code": "GA",
        "country_long_code": "GAB",
        "airport_description": "Leon M'BA International",
        "latitude": "0.45",
        "longitude": "9.416667"
    },
    {
        "airport_name": "Lihue",
        "airport_code": "LIH",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Lihue Airport",
        "latitude": "21.983333",
        "longitude": "-159.35"
    },
    {
        "airport_name": "Lijiang",
        "airport_code": "LJG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Lijiang Sanyi Airport",
        "latitude": "26.68",
        "longitude": "100.246"
    },
    {
        "airport_name": "Lille",
        "airport_code": "LIL",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Lille-Lesquin Airport",
        "latitude": "50.566667",
        "longitude": "3.1"
    },
    {
        "airport_name": "Lilongwe",
        "airport_code": "LLW",
        "country_name": "Malawi",
        "country_code": "MW",
        "country_long_code": "MWI",
        "airport_description": "Kamuzu International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Lima",
        "airport_code": "LIM",
        "country_name": "Peru",
        "country_code": "PE",
        "country_long_code": "PER",
        "airport_description": "Jorge Chavez International",
        "latitude": "-12.021944",
        "longitude": "-77.114444"
    },
    {
        "airport_name": "Lincang",
        "airport_code": "LNJ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Lincang Airport",
        "latitude": "23.7383",
        "longitude": "100.0257"
    },
    {
        "airport_name": "Lindu",
        "airport_code": "LDS",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Lindu Airport",
        "latitude": "47.7519",
        "longitude": "129.0192"
    },
    {
        "airport_name": "Link\u00f6ping",
        "airport_code": "LPI",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Link\u00f6ping City Airport",
        "latitude": "58.4062",
        "longitude": "15.6805"
    },
    {
        "airport_name": "Linyi",
        "airport_code": "LYI",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Linyi Airport",
        "latitude": "35.0461",
        "longitude": "118.4128"
    },
    {
        "airport_name": "Lisbon",
        "airport_code": "LIS",
        "country_name": "Portugal",
        "country_code": "PT",
        "country_long_code": "PRT",
        "airport_description": "Lisbon airport",
        "latitude": "38.781389",
        "longitude": "-9.135833"
    },
    {
        "airport_name": "Liuzhou",
        "airport_code": "LZH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Liuzhou Bailian Airport",
        "latitude": "24.2075",
        "longitude": "109.3919"
    },
    {
        "airport_name": "Livingstone",
        "airport_code": "LVI",
        "country_name": "Zambia",
        "country_code": "ZM",
        "country_long_code": "ZMB",
        "airport_description": "Livingstone",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Ljubljana",
        "airport_code": "LJU",
        "country_name": "Slovenia",
        "country_code": "SI",
        "country_long_code": "SVN",
        "airport_description": "Joze Pucnik",
        "latitude": "46.223611",
        "longitude": "14.4575"
    },
    {
        "airport_name": "Lome",
        "airport_code": "LFW",
        "country_name": "Togo",
        "country_code": "TG",
        "country_long_code": "TGO",
        "airport_description": "G Eyadema International",
        "latitude": "6.166667",
        "longitude": "1.25"
    },
    {
        "airport_name": "London",
        "airport_code": "LGW",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Gatwick Airport",
        "latitude": "51.148056",
        "longitude": "-0.190278"
    },
    {
        "airport_name": "London",
        "airport_code": "LHR",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Heathrow Airport",
        "latitude": "51.469722",
        "longitude": "-0.451389"
    },
    {
        "airport_name": "London",
        "airport_code": "LON",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "All Airports",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "London Canada",
        "airport_code": "YXU",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "London International Airport",
        "latitude": "43.035556",
        "longitude": "-81.153889"
    },
    {
        "airport_name": "London City Airport",
        "airport_code": "LCY",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "London City Airport",
        "latitude": "-33.05",
        "longitude": "27.816667"
    },
    {
        "airport_name": "Longyearbyen",
        "airport_code": "LYR",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Svalbard Airport, Longyear",
        "latitude": "78.2461",
        "longitude": "15.4656"
    },
    {
        "airport_name": "Lopburi",
        "airport_code": "LPT",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Lopburi Airport",
        "latitude": "18.2709",
        "longitude": "99.5043"
    },
    {
        "airport_name": "Los Angeles",
        "airport_code": "LAX",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Los Angeles International",
        "latitude": "33.9425",
        "longitude": "-118.407222"
    },
    {
        "airport_name": "Los Mochis",
        "airport_code": "LMM",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Valle del Fuerte Federal International Airport",
        "latitude": "25.6852",
        "longitude": "-109.081"
    },
    {
        "airport_name": "Luanda",
        "airport_code": "LAD",
        "country_name": "Angola",
        "country_code": "AO",
        "country_long_code": "AGO",
        "airport_description": "Luanda International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Luang Prabang",
        "airport_code": "LPQ",
        "country_name": "Lao (People's Democratic Republic)",
        "country_code": "LA",
        "country_long_code": "LAO",
        "airport_description": "Luang Prabang International Airport",
        "latitude": "19.8973",
        "longitude": "102.1611"
    },
    {
        "airport_name": "Lubumbashi",
        "airport_code": "FBM",
        "country_name": "Congo (Democratic Republic of)",
        "country_code": "CD",
        "country_long_code": "COG",
        "airport_description": "Lubumbashi International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Lucknow",
        "airport_code": "LKO",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Chaudhary Charan Singh",
        "latitude": "26.766667",
        "longitude": "80.883333"
    },
    {
        "airport_name": "Lule\u00e5",
        "airport_code": "LLA",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Lule\u00e5 Airport",
        "latitude": "65.5438",
        "longitude": "22.121"
    },
    {
        "airport_name": "L\u00fcliang",
        "airport_code": "LLV",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "L\u00fcliang Airport",
        "latitude": "37.6161",
        "longitude": "111.856"
    },
    {
        "airport_name": "Lumid Pau",
        "airport_code": "LUM",
        "country_name": "Papua New Guinea",
        "country_code": "PG",
        "country_long_code": "PNG",
        "airport_description": "Lumid Pau Airport",
        "latitude": "24.4011",
        "longitude": "97.7331"
    },
    {
        "airport_name": "Luoyang",
        "airport_code": "LYA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Luoyang Beijiao Airport",
        "latitude": "34.7411",
        "longitude": "112.388"
    },
    {
        "airport_name": "Lusaka",
        "airport_code": "LUN",
        "country_name": "Zambia",
        "country_code": "ZM",
        "country_long_code": "ZMB",
        "airport_description": "Lusaka International Airport",
        "latitude": "-15.416667",
        "longitude": "28.333333"
    },
    {
        "airport_name": "Luxembourg",
        "airport_code": "LUX",
        "country_name": "Luxembourg",
        "country_code": "LU",
        "country_long_code": "LUX",
        "airport_description": "Luxembourg Airport",
        "latitude": "49.616667",
        "longitude": "6.2"
    },
    {
        "airport_name": "Luxor",
        "airport_code": "LXR",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Luxor International Airport",
        "latitude": "25.671",
        "longitude": "32.7066"
    },
    {
        "airport_name": "Luzhou",
        "airport_code": "LZO",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Luzhou Yunlong Airport",
        "latitude": "28.8522",
        "longitude": "105.3936"
    },
    {
        "airport_name": "Lyon",
        "airport_code": "LYS",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Saint Exupery",
        "latitude": "45.725556",
        "longitude": "5.081111"
    },
    {
        "airport_name": "Macau",
        "airport_code": "MFM",
        "country_name": "Macao ",
        "country_code": "MO",
        "country_long_code": "",
        "airport_description": "Macau International Airport",
        "latitude": "22.1496",
        "longitude": "113.5916"
    },
    {
        "airport_name": "Madinah",
        "airport_code": "MED",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Mohammad Bin Abdulaziz",
        "latitude": "24.533333",
        "longitude": "39.716667"
    },
    {
        "airport_name": "Madrid",
        "airport_code": "MAD",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Adolfo Suarez Barajas",
        "latitude": "40.466667",
        "longitude": "-3.566667"
    },
    {
        "airport_name": "Madurai",
        "airport_code": "IXM",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Madurai",
        "latitude": "9.834444",
        "longitude": "78.093333"
    },
    {
        "airport_name": "Mae Hong Son",
        "airport_code": "HGN",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Mae Hong Son Airport",
        "latitude": "19.3016",
        "longitude": "97.9758"
    },
    {
        "airport_name": "Mae Sot",
        "airport_code": "MAQ",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Mae Sot Airport",
        "latitude": "16.6999",
        "longitude": "98.5451"
    },
    {
        "airport_name": "Makassar",
        "airport_code": "UPG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sultan Hasanuddin International Airport",
        "latitude": "-5.116667",
        "longitude": "119.4"
    },
    {
        "airport_name": "Malabo",
        "airport_code": "SSG",
        "country_name": "Guinea",
        "country_code": "GN",
        "country_long_code": "",
        "airport_description": "International",
        "latitude": "3.75",
        "longitude": "8.783333"
    },
    {
        "airport_name": "Malaga",
        "airport_code": "AGP",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Malaga Airport",
        "latitude": "36.675",
        "longitude": "-4.499167"
    },
    {
        "airport_name": "Malang",
        "airport_code": "MLG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Abdul Rachman Saleh",
        "latitude": "-7.926667",
        "longitude": "112.708889"
    },
    {
        "airport_name": "Malatya",
        "airport_code": "MLX",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Erhac",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Male",
        "airport_code": "MLE",
        "country_name": "Maldives Islands",
        "country_code": "MV",
        "country_long_code": "MDV",
        "airport_description": "Velana International",
        "latitude": "4.191944",
        "longitude": "73.529167"
    },
    {
        "airport_name": "Malm\u00f6",
        "airport_code": "MMA",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Malm\u00f6 Airport (Sturup)",
        "latitude": "55.5363",
        "longitude": "13.3762"
    },
    {
        "airport_name": "Malm\u00f6",
        "airport_code": "MMX",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Malm\u00f6 Airport",
        "latitude": "55.5363",
        "longitude": "13.3762"
    },
    {
        "airport_name": "Malta",
        "airport_code": "MLA",
        "country_name": "Malta",
        "country_code": "MT",
        "country_long_code": "MLT",
        "airport_description": "Luqa International",
        "latitude": "35.866667",
        "longitude": "14.483333"
    },
    {
        "airport_name": "Manado",
        "airport_code": "MDC",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sam Ratulangi International Airport",
        "latitude": "1.5493",
        "longitude": "124.926"
    },
    {
        "airport_name": "Managua",
        "airport_code": "MGA",
        "country_name": "Nicaragua",
        "country_code": "NI",
        "country_long_code": "NIC",
        "airport_description": "Augusto C. Sandino International Airport",
        "latitude": "12.1415",
        "longitude": "-86.1682"
    },
    {
        "airport_name": "Manchester",
        "airport_code": "MAN",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Manchester Airport",
        "latitude": "53.35",
        "longitude": "-2.266667"
    },
    {
        "airport_name": "Mandalay",
        "airport_code": "MDL",
        "country_name": "Myanmar",
        "country_code": "MM",
        "country_long_code": "MMR",
        "airport_description": "Mandalay International Airport",
        "latitude": "21.7022",
        "longitude": "95.9779"
    },
    {
        "airport_name": "Mangalore",
        "airport_code": "IXE",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Mangalore",
        "latitude": "12.961389",
        "longitude": "74.89"
    },
    {
        "airport_name": "Manila",
        "airport_code": "MNL",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Ninoy Aquino International",
        "latitude": "14.516667",
        "longitude": "121.016667"
    },
    {
        "airport_name": "Manzanillo",
        "airport_code": "ZLO",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Playa de Oro International Airport",
        "latitude": "19.1448",
        "longitude": "-104.5587"
    },
    {
        "airport_name": "Maputo",
        "airport_code": "MPM",
        "country_name": "Mozambique",
        "country_code": "MZ",
        "country_long_code": "MOZ",
        "airport_description": "Maputo International Airport",
        "latitude": "-25.916667",
        "longitude": "32.566667"
    },
    {
        "airport_name": "Mar del Plata",
        "airport_code": "MDQ",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "\u00c1stor Piazzolla International Airport",
        "latitude": "-37.9342",
        "longitude": "-57.5733"
    },
    {
        "airport_name": "Mardin",
        "airport_code": "MQM",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Mardin",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Maribor",
        "airport_code": "MQP",
        "country_name": "Slovenia",
        "country_code": "SI",
        "country_long_code": "SVN",
        "airport_description": "Maribor Edvard Rusjan Airport",
        "latitude": "-25.3842",
        "longitude": "31.1056"
    },
    {
        "airport_name": "Marquette",
        "airport_code": "MQT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Sawyer International Airport",
        "latitude": "46.3536",
        "longitude": "-87.3954"
    },
    {
        "airport_name": "Marrakech",
        "airport_code": "RAK",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Menara",
        "latitude": "31.606944",
        "longitude": "-8.036389"
    },
    {
        "airport_name": "Marseille",
        "airport_code": "MRS",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Provence",
        "latitude": "43.436667",
        "longitude": "5.215"
    },
    {
        "airport_name": "Marsh Harbour",
        "airport_code": "MHH",
        "country_name": "Bahamas",
        "country_code": "BS",
        "country_long_code": "BHS",
        "airport_description": "Leonard M. Thompson International Airport",
        "latitude": "26.5114",
        "longitude": "-77.0835"
    },
    {
        "airport_name": "Matamoros",
        "airport_code": "MAM",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Servando Canales Intl Airport",
        "latitude": "25.7699",
        "longitude": "-97.5253"
    },
    {
        "airport_name": "Mauritius",
        "airport_code": "MRU",
        "country_name": "Mauritius Island",
        "country_code": "MU",
        "country_long_code": "MUS",
        "airport_description": "Sir S.Ramgoolam International",
        "latitude": "-20.430278",
        "longitude": "57.683611"
    },
    {
        "airport_name": "Mazatl\u00e1n",
        "airport_code": "MZT",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Rafael Buelna International Airport",
        "latitude": "23.1614",
        "longitude": "-106.2661"
    },
    {
        "airport_name": "Mbuji Mayi",
        "airport_code": "JMJ",
        "country_name": "Congo (Democratic Republic of)",
        "country_code": "CD",
        "country_long_code": "COG",
        "airport_description": "Mbuji Mayi Airport",
        "latitude": "21.9739",
        "longitude": "100.76"
    },
    {
        "airport_name": "McAllen",
        "airport_code": "MFE",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "McAllen Miller International Airport",
        "latitude": "26.1758",
        "longitude": "-98.2386"
    },
    {
        "airport_name": "Medan",
        "airport_code": "KNO",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Kualanamu International Airport",
        "latitude": "3.6333568",
        "longitude": "98.8735764"
    },
    {
        "airport_name": "Medan",
        "airport_code": "MES",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Kualanamu International Airport",
        "latitude": "3.5581",
        "longitude": "98.6717"
    },
    {
        "airport_name": "Medford",
        "airport_code": "MFR",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Rogue Valley International\u2013Medford Airport",
        "latitude": "42.3742",
        "longitude": "-122.873"
    },
    {
        "airport_name": "Melbourne",
        "airport_code": "MEL",
        "country_name": "Australia",
        "country_code": "AU",
        "country_long_code": "AUS",
        "airport_description": "Melbourne Airport",
        "latitude": "-37.673333",
        "longitude": "144.843333"
    },
    {
        "airport_name": "Melbourne",
        "airport_code": "MLB",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Melbourne Orlando International Airport",
        "latitude": "28.1028",
        "longitude": "-80.6453"
    },
    {
        "airport_name": "Memphis",
        "airport_code": "MEM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Memphis International Airport",
        "latitude": "35.066667",
        "longitude": "-89.966667"
    },
    {
        "airport_name": "Mendoza",
        "airport_code": "MDZ",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Governor Francisco Gabrielli International Airport",
        "latitude": "-32.8317",
        "longitude": "-68.7928"
    },
    {
        "airport_name": "Menorca",
        "airport_code": "MAH",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Menorca",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Merauke",
        "airport_code": "MKQ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Mopah Airport",
        "latitude": "-8.5203",
        "longitude": "140.4186"
    },
    {
        "airport_name": "M\u00e9rida",
        "airport_code": "MID",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Manuel Crescencio Rej\u00f3n International Airport",
        "latitude": "20.937",
        "longitude": "-89.6577"
    },
    {
        "airport_name": "Merlo",
        "airport_code": "RLO",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Valle del Conlara International Airport",
        "latitude": "-32.3826",
        "longitude": "-65.1817"
    },
    {
        "airport_name": "Mexicali",
        "airport_code": "MXL",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Rodolfo S\u00e1nchez Taboada Intl Airport",
        "latitude": "32.6306",
        "longitude": "-115.2417"
    },
    {
        "airport_name": "Mexico City",
        "airport_code": "MEX",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Benito Juarez International",
        "latitude": "19.436389",
        "longitude": "-99.072222"
    },
    {
        "airport_name": "Miami",
        "airport_code": "MIA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Miami International",
        "latitude": "25.783333",
        "longitude": "-80.266667"
    },
    {
        "airport_name": "Mianyang",
        "airport_code": "MIG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Mianyang Nanjiao Airport",
        "latitude": "31.4281",
        "longitude": "104.7407"
    },
    {
        "airport_name": "Middlesbrough",
        "airport_code": "MME",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Teesside International Airport",
        "latitude": "54.5092",
        "longitude": "-1.4294"
    },
    {
        "airport_name": "Midland",
        "airport_code": "MAF",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Midland International Air and Space Port",
        "latitude": "31.9425",
        "longitude": "-102.2023"
    },
    {
        "airport_name": "Milan",
        "airport_code": "MXP",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Malpensa",
        "latitude": "45.633333",
        "longitude": "8.733333"
    },
    {
        "airport_name": "Milan",
        "airport_code": "MIL",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Milan Metropolitan Area Airports",
        "latitude": "45.6306",
        "longitude": "8.7281"
    },
    {
        "airport_name": "Milan",
        "airport_code": "LIN",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Milan Linate Airport",
        "latitude": "45.4451",
        "longitude": "9.2767"
    },
    {
        "airport_name": "Minatitl\u00e1n",
        "airport_code": "MTT",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Minatitl\u00e1n/Coatzacoalcos National Airport",
        "latitude": "18.1034",
        "longitude": "-94.5807"
    },
    {
        "airport_name": "Miri",
        "airport_code": "MYY",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Miri Airport",
        "latitude": "4.452778",
        "longitude": "114"
    },
    {
        "airport_name": "Missoula",
        "airport_code": "MSO",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Missoula International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Mogadishu",
        "airport_code": "MGQ",
        "country_name": "Somalia",
        "country_code": "SO",
        "country_long_code": "SOM",
        "airport_description": "Aden Adde International Airport",
        "latitude": "2.014444",
        "longitude": "45.304722"
    },
    {
        "airport_name": "Moline",
        "airport_code": "MLI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Quad City International Airport",
        "latitude": "41.4485",
        "longitude": "-90.5075"
    },
    {
        "airport_name": "Mombasa",
        "airport_code": "MBA",
        "country_name": "Kenya",
        "country_code": "KE",
        "country_long_code": "KEN",
        "airport_description": "Moi International",
        "latitude": "-4.033333",
        "longitude": "39.583333"
    },
    {
        "airport_name": "Monastir",
        "airport_code": "MIR",
        "country_name": "Tunisia",
        "country_code": "TN",
        "country_long_code": "TUN",
        "airport_description": "Monastir Habib Bourguiba International Airport",
        "latitude": "35.7581",
        "longitude": "10.7547"
    },
    {
        "airport_name": "Moncton",
        "airport_code": "YQM",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Greater Moncton International Airport",
        "latitude": "46.112221",
        "longitude": "-64.678611"
    },
    {
        "airport_name": "Monrovia",
        "airport_code": "MLW",
        "country_name": "Liberia",
        "country_code": "LR",
        "country_long_code": "LBR",
        "airport_description": "Spriggs Payne Airport",
        "latitude": "6.2891",
        "longitude": "-10.7587"
    },
    {
        "airport_name": "Monterrey",
        "airport_code": "MTY",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Mariano Escobedo International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Montevideo",
        "airport_code": "MVD",
        "country_name": "Uruguay",
        "country_code": "UY",
        "country_long_code": "URY",
        "airport_description": "Carrasco International Airport",
        "latitude": "-34.8384",
        "longitude": "-56.0308"
    },
    {
        "airport_name": "Montgomery",
        "airport_code": "MGM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Montgomery Regional Airport",
        "latitude": "32.3006",
        "longitude": "-86.3939"
    },
    {
        "airport_name": "Montpellier",
        "airport_code": "MPL",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Mediterranee",
        "latitude": "43.583333",
        "longitude": "3.966667"
    },
    {
        "airport_name": "Montreal",
        "airport_code": "YUL",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Montreal-Pierre Elliott Trudeau International Airport",
        "latitude": "45.4656888",
        "longitude": "-73.7480563"
    },
    {
        "airport_name": "Montreal",
        "airport_code": "YMQ",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Montreal Metropolitan Area Airports",
        "latitude": "45.4706",
        "longitude": "-73.7408"
    },
    {
        "airport_name": "Morelia",
        "airport_code": "MLM",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Francisco J. Mujica International Airport",
        "latitude": "19.8499",
        "longitude": "-101.0255"
    },
    {
        "airport_name": "Moroni",
        "airport_code": "HAH",
        "country_name": "Comoros",
        "country_code": "KM",
        "country_long_code": "COM",
        "airport_description": "Prince Said Ibrahim International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Moscow",
        "airport_code": "MOW",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "All Airports",
        "latitude": "55.4103069",
        "longitude": "37.8998764"
    },
    {
        "airport_name": "Moscow",
        "airport_code": "SVO",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Sheremetyevo International",
        "latitude": "55.972778",
        "longitude": "37.414722"
    },
    {
        "airport_name": "Mosinee",
        "airport_code": "CWA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Central Wisconsin Airport",
        "latitude": "44.7776",
        "longitude": "-89.6668"
    },
    {
        "airport_name": "Mostar",
        "airport_code": "OMO",
        "country_name": "Bosnia and Herzegovina",
        "country_code": "BA",
        "country_long_code": "BIH",
        "airport_description": "Mostar Airport",
        "latitude": "43.2829",
        "longitude": "17.8459"
    },
    {
        "airport_name": "Mosul",
        "airport_code": "MSU",
        "country_name": "Iraq",
        "country_code": "IQ",
        "country_long_code": "IRQ",
        "airport_description": "Mosul International Airport",
        "latitude": "-29.3016",
        "longitude": "27.4982"
    },
    {
        "airport_name": "Mudanjiang",
        "airport_code": "MDG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Mudanjiang Hailang Airport",
        "latitude": "44.5241",
        "longitude": "129.569"
    },
    {
        "airport_name": "Multan",
        "airport_code": "MUX",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "International",
        "latitude": "30.203333",
        "longitude": "71.419167"
    },
    {
        "airport_name": "Mumbai",
        "airport_code": "BOM",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Chhatrapati S Maharaj",
        "latitude": "19.088611",
        "longitude": "72.868056"
    },
    {
        "airport_name": "Munich",
        "airport_code": "MUC",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Munich International",
        "latitude": "48.35",
        "longitude": "11.783333"
    },
    {
        "airport_name": "Murcia",
        "airport_code": "MJV",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Murcia-San Javier Airport",
        "latitude": "37.775",
        "longitude": "-0.8124"
    },
    {
        "airport_name": "Mus",
        "airport_code": "MSR",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Mus",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Muscat",
        "airport_code": "MCT",
        "country_name": "Oman",
        "country_code": "OM",
        "country_long_code": "OMN",
        "airport_description": "Muscat International",
        "latitude": "23.633333",
        "longitude": "58.533333"
    },
    {
        "airport_name": "Mykonos",
        "airport_code": "JMK",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Mykonos International Airport",
        "latitude": "37.433333",
        "longitude": "25.35"
    },
    {
        "airport_name": "Mytilene",
        "airport_code": "MJT",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Mytilene Intenational Airport",
        "latitude": "39.056667",
        "longitude": "26.598333"
    },
    {
        "airport_name": "Nador",
        "airport_code": "NDR",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "El Aroui",
        "latitude": "35.2",
        "longitude": "-2.916667"
    },
    {
        "airport_name": "Nagasaki",
        "airport_code": "NGS",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Nagasaki Airport",
        "latitude": "32.9304",
        "longitude": "129.9226"
    },
    {
        "airport_name": "Nagpur",
        "airport_code": "NAG",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Dr. Babasaheb Ambedkar International Airport",
        "latitude": "21.0922",
        "longitude": "79.0472"
    },
    {
        "airport_name": "Nairobi",
        "airport_code": "NBO",
        "country_name": "Kenya",
        "country_code": "KE",
        "country_long_code": "KEN",
        "airport_description": "Jomo Kenyatta International",
        "latitude": "1.316667",
        "longitude": "36.933333"
    },
    {
        "airport_name": "Najaf",
        "airport_code": "NJF",
        "country_name": "Iraq",
        "country_code": "IQ",
        "country_long_code": "IRQ",
        "airport_description": "Al Najaf International Airport",
        "latitude": "31.9899",
        "longitude": "44.4043"
    },
    {
        "airport_name": "Nakina",
        "airport_code": "YQB",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Nakina Airport",
        "latitude": "46.791111",
        "longitude": "-71.393333"
    },
    {
        "airport_name": "Nanchang",
        "airport_code": "KHN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Nanchang Changbei International Airport",
        "latitude": "28.865",
        "longitude": "115.9006"
    },
    {
        "airport_name": "Nanchong",
        "airport_code": "NAO",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Nanchong Gaoping Airport",
        "latitude": "30.7955",
        "longitude": "106.1627"
    },
    {
        "airport_name": "Nanjing",
        "airport_code": "NKG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Nanjing Lukou International",
        "latitude": "31.741944",
        "longitude": "118.861944"
    },
    {
        "airport_name": "Nanning",
        "airport_code": "NNG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Nanning Wuxu",
        "latitude": "22.783333",
        "longitude": "108"
    },
    {
        "airport_name": "Nantes",
        "airport_code": "NTE",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Atlantique",
        "latitude": "47.15",
        "longitude": "-1.6"
    },
    {
        "airport_name": "Nantong",
        "airport_code": "NTG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Nantong Xingdong International Airport",
        "latitude": "32.0708",
        "longitude": "120.9767"
    },
    {
        "airport_name": "Naples",
        "airport_code": "NAP",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Capodichino Airport",
        "latitude": "40.886111",
        "longitude": "14.290833"
    },
    {
        "airport_name": "Nashville",
        "airport_code": "BNA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Nashville International Airport",
        "latitude": "36.124444",
        "longitude": "-86.678056"
    },
    {
        "airport_name": "N''Djamena",
        "airport_code": "NDJ",
        "country_name": "Chad",
        "country_code": "TD",
        "country_long_code": "TCD",
        "airport_description": "Hassan Djamous International",
        "latitude": "12.133333",
        "longitude": "15.033333"
    },
    {
        "airport_name": "Ndola",
        "airport_code": "NLA",
        "country_name": "Zambia",
        "country_code": "ZM",
        "country_long_code": "ZMB",
        "airport_description": "Ndola Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Nejran",
        "airport_code": "EAM",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Nejran Airport",
        "latitude": "17.6",
        "longitude": "44.416667"
    },
    {
        "airport_name": "Neodesha",
        "airport_code": "NDS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Neodesha Airport",
        "latitude": "-27.9933",
        "longitude": "119.2886"
    },
    {
        "airport_name": "Neom",
        "airport_code": "NUM",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Neom Bay Airport",
        "latitude": "27.9164824",
        "longitude": "35.2895418"
    },
    {
        "airport_name": "Neuqu\u00e9n",
        "airport_code": "NQN",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Presidente Per\u00f3n International Airport",
        "latitude": "-38.949",
        "longitude": "-68.1557"
    },
    {
        "airport_name": "Nev\u015fehir",
        "airport_code": "NAV",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Nev\u015fehir Kapadokya Airport",
        "latitude": "38.7719",
        "longitude": "34.5344"
    },
    {
        "airport_name": "New York",
        "airport_code": "EWR",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Newark Liberty International",
        "latitude": "40.6925",
        "longitude": "-74.168611"
    },
    {
        "airport_name": "New York",
        "airport_code": "JFK",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "John F Kennedy International",
        "latitude": "40.633333",
        "longitude": "-73.783333"
    },
    {
        "airport_name": "New York",
        "airport_code": "NYC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "All Airports",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Newcastle",
        "airport_code": "NCL",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "International",
        "latitude": "55.033333",
        "longitude": "-1.7"
    },
    {
        "airport_name": "Neytiri",
        "airport_code": "NYT",
        "country_name": "Myanmar",
        "country_code": "MM",
        "country_long_code": "MMR",
        "airport_description": "Nyatapola Airport",
        "latitude": "19.6235",
        "longitude": "96.201"
    },
    {
        "airport_name": "Ngurah Rai",
        "airport_code": "WMT",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Ngurah Rai International Airport",
        "latitude": "27.8167",
        "longitude": "106.3333"
    },
    {
        "airport_name": "Nha Trang",
        "airport_code": "CXR",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Cam Ranh International Airport",
        "latitude": "11.9981",
        "longitude": "109.2194"
    },
    {
        "airport_name": "Niamey",
        "airport_code": "NIM",
        "country_name": "Niger",
        "country_code": "NE",
        "country_long_code": "NER",
        "airport_description": "Diori Hamani International",
        "latitude": "13.483333",
        "longitude": "2.166667"
    },
    {
        "airport_name": "Nice",
        "airport_code": "NCE",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Cote D'Azur",
        "latitude": "43.665278",
        "longitude": "7.215"
    },
    {
        "airport_name": "Ningbo",
        "airport_code": "NGB",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Ningbo Lishe International Airport",
        "latitude": "29.8267",
        "longitude": "121.4619"
    },
    {
        "airport_name": "Ninglang",
        "airport_code": "NLH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Ninglang Luguhu Airport",
        "latitude": "27.54",
        "longitude": "100.759"
    },
    {
        "airport_name": "North Bay",
        "airport_code": "YYB",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Jack Garland Airport",
        "latitude": "46.363611",
        "longitude": "-79.422778"
    },
    {
        "airport_name": "North Eleuthera",
        "airport_code": "ELH",
        "country_name": "Bahamas",
        "country_code": "BS",
        "country_long_code": "BHS",
        "airport_description": "North Eleuthera Airport",
        "latitude": "25.4748",
        "longitude": "-76.6835"
    },
    {
        "airport_name": "Norwich",
        "airport_code": "NWI",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Norwich International Airport",
        "latitude": "52.6758",
        "longitude": "1.2828"
    },
    {
        "airport_name": "Nouakchott",
        "airport_code": "NKC",
        "country_name": "Mauritania",
        "country_code": "MR",
        "country_long_code": "MRT",
        "airport_description": "Nouakchott",
        "latitude": "18.089722",
        "longitude": "-15.953889"
    },
    {
        "airport_name": "Nuevo Laredo",
        "airport_code": "NLU",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Quetzalcoatl International Airport",
        "latitude": "19.7577",
        "longitude": "-99.0725"
    },
    {
        "airport_name": "Nuevo Laredo",
        "airport_code": "NLD",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Nuevo Laredo International Airport",
        "latitude": "27.4439",
        "longitude": "-99.5705"
    },
    {
        "airport_name": "Nuremberg",
        "airport_code": "NUE",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Nuremberg Airport",
        "latitude": "49.498611",
        "longitude": "11.066944"
    },
    {
        "airport_name": "Nuuk",
        "airport_code": "GOH",
        "country_name": "Greenland",
        "country_code": "GL",
        "country_long_code": "GRL",
        "airport_description": "Nuuk Airport",
        "latitude": "64.1909",
        "longitude": "-51.6781"
    },
    {
        "airport_name": "Oakland",
        "airport_code": "OAK",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Oakland International",
        "latitude": "37.716667",
        "longitude": "-122.216667"
    },
    {
        "airport_name": "Oaxaca",
        "airport_code": "OAX",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Xoxocotl\u00e1n International Airport",
        "latitude": "16.9999",
        "longitude": "-96.7266"
    },
    {
        "airport_name": "Odesa",
        "airport_code": "ODS",
        "country_name": "Ukraine",
        "country_code": "UA",
        "country_long_code": "UKR",
        "airport_description": "Odesa International Airport",
        "latitude": "46.4268",
        "longitude": "30.6765"
    },
    {
        "airport_name": "Oklahoma City ",
        "airport_code": "OKC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Will Rogers World Airport",
        "latitude": "35.393056",
        "longitude": "-97.600833"
    },
    {
        "airport_name": "Oradea",
        "airport_code": "OMR",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Oradea International Airport",
        "latitude": "47.0253",
        "longitude": "21.9025"
    },
    {
        "airport_name": "Orbatax",
        "airport_code": "RCB",
        "country_name": "Somalia",
        "country_code": "SO",
        "country_long_code": "SOM",
        "airport_description": "Orca Base Airport",
        "latitude": "-28.74",
        "longitude": "32.0921"
    },
    {
        "airport_name": "Ordu-Giresun",
        "airport_code": "OGU",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Ordu\u2013Giresun Airport",
        "latitude": "40.9667",
        "longitude": "38.08"
    },
    {
        "airport_name": "Orlando",
        "airport_code": "MCO",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Orlando International Airport",
        "latitude": "28.429444",
        "longitude": "-81.308889"
    },
    {
        "airport_name": "Orlando",
        "airport_code": "ORL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Orlando Metropolitan Area Airports",
        "latitude": "28.4294",
        "longitude": "-81.3089"
    },
    {
        "airport_name": "Osaka",
        "airport_code": "KIX",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Kansai International Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Osaka",
        "airport_code": "OSA",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Osaka Metropolitan Area Airports",
        "latitude": "34.4347",
        "longitude": "135.2442"
    },
    {
        "airport_name": "Oslo",
        "airport_code": "OSL",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Gardermoen",
        "latitude": "60.193889",
        "longitude": "11.100278"
    },
    {
        "airport_name": "\u00d6stersund",
        "airport_code": "OSD",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "\u00c5re \u00d6stersund Airport",
        "latitude": "63.1944",
        "longitude": "14.5003"
    },
    {
        "airport_name": "Ostrava",
        "airport_code": "OSR",
        "country_name": "Czech Republic",
        "country_code": "CZ",
        "country_long_code": "CZE",
        "airport_description": "Leo\u0161 Jan\u00e1\u010dek Airport Ostrava",
        "latitude": "49.6963",
        "longitude": "18.1111"
    },
    {
        "airport_name": "Ottawa",
        "airport_code": "YOW",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Macdonald Cartier International",
        "latitude": "45.3225",
        "longitude": "-75.669167"
    },
    {
        "airport_name": "Ouagadougou",
        "airport_code": "OUA",
        "country_name": "Burkina Faso",
        "country_code": "BF",
        "country_long_code": "BFA",
        "airport_description": "Ouagadougou",
        "latitude": "12.35",
        "longitude": "-1.516667"
    },
    {
        "airport_name": "Ouarzazate",
        "airport_code": "OZZ",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Ouarzazate",
        "latitude": "30.916667",
        "longitude": "-6.916667"
    },
    {
        "airport_name": "Oujda",
        "airport_code": "OUD",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Angads",
        "latitude": "34.683333",
        "longitude": "-1.75"
    },
    {
        "airport_name": "Oviedo",
        "airport_code": "OVD",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Asturias",
        "latitude": "43.333333",
        "longitude": "-6"
    },
    {
        "airport_name": "Padang",
        "airport_code": "PDG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Minangkabau",
        "latitude": "-0.786944",
        "longitude": "100.280556"
    },
    {
        "airport_name": "Palanga",
        "airport_code": "PLQ",
        "country_name": "Lithuania",
        "country_code": "LT",
        "country_long_code": "LTU",
        "airport_description": "Palanga International Airport",
        "latitude": "55.9733",
        "longitude": "21.0939"
    },
    {
        "airport_name": "Palangka Raya",
        "airport_code": "PKY",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Tjilik Riwut Airport",
        "latitude": "-2.2251",
        "longitude": "113.9431"
    },
    {
        "airport_name": "Palembang",
        "airport_code": "PLM",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sultan Mahmud Badaruddin II",
        "latitude": "-2.9",
        "longitude": "104.7"
    },
    {
        "airport_name": "Palermo",
        "airport_code": "PMO",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Punta Raisi",
        "latitude": "38.175833",
        "longitude": "13.091111"
    },
    {
        "airport_name": "Palm Springs",
        "airport_code": "PSP",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Palm Springs International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Palma Mallorca",
        "airport_code": "PMI",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Palma Mallorca",
        "latitude": "39.5517448",
        "longitude": "2.73359"
    },
    {
        "airport_name": "Palu",
        "airport_code": "PLW",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Mutiara SIS Al-Jufrie Airport",
        "latitude": "-0.9185",
        "longitude": "119.9098"
    },
    {
        "airport_name": "Panama City",
        "airport_code": "ECP",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Northwest Florida Beaches International Airport",
        "latitude": "30.3571",
        "longitude": "-85.7954"
    },
    {
        "airport_name": "Pangkalpinang",
        "airport_code": "PGK",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Depati Amir",
        "latitude": "2.166667",
        "longitude": "106.133333"
    },
    {
        "airport_name": "Panglao",
        "airport_code": "LGP",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Bohol\u2013Panglao International Airport",
        "latitude": "13.166667",
        "longitude": "123.733333"
    },
    {
        "airport_name": "Pantelleria",
        "airport_code": "PNL",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Pantelleria Airport",
        "latitude": "36.8165",
        "longitude": "11.9687"
    },
    {
        "airport_name": "Paramaribo",
        "airport_code": "PBM",
        "country_name": "Suriname",
        "country_code": "SR",
        "country_long_code": "SUR",
        "airport_description": "Johan Adolf Pengel International Airport",
        "latitude": "5.4528",
        "longitude": "-55.1878"
    },
    {
        "airport_name": "Paran\u00e1",
        "airport_code": "PRA",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "General Justo Jos\u00e9 de Urquiza Airport",
        "latitude": "-31.7948",
        "longitude": "-60.4804"
    },
    {
        "airport_name": "Paris",
        "airport_code": "CDG",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Charles De Gaulle",
        "latitude": "49.016667",
        "longitude": "2.55"
    },
    {
        "airport_name": "Paris",
        "airport_code": "PAR",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "All Airports",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Paris",
        "airport_code": "ORY",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Paris Orly Airport",
        "latitude": "48.7262",
        "longitude": "2.3652"
    },
    {
        "airport_name": "Pasco",
        "airport_code": "PSC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Tri-Cities Airport",
        "latitude": "46.2647",
        "longitude": "-119.119"
    },
    {
        "airport_name": "Patna",
        "airport_code": "PAT",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Jay Prakash Narayan Airport",
        "latitude": "12.961389",
        "longitude": "74.89"
    },
    {
        "airport_name": "Pau",
        "airport_code": "PUF",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Pyrenees",
        "latitude": "43.38",
        "longitude": "-0.418611"
    },
    {
        "airport_name": "Pekanbaru",
        "airport_code": "PKU",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Sultan Syarif Kasim II",
        "latitude": "0.460833",
        "longitude": "101.444444"
    },
    {
        "airport_name": "Pellston",
        "airport_code": "PLN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Pellston Regional Airport",
        "latitude": "45.5709",
        "longitude": "-84.7967"
    },
    {
        "airport_name": "Penang",
        "airport_code": "PEN",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Penang International Airport",
        "latitude": "5.3",
        "longitude": "100.266667"
    },
    {
        "airport_name": "Pensacola",
        "airport_code": "PNS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Pensacola International\u00a0Airport",
        "latitude": "30.466667",
        "longitude": "-87.183333"
    },
    {
        "airport_name": "Perth",
        "airport_code": "PER",
        "country_name": "Australia",
        "country_code": "AU",
        "country_long_code": "AUS",
        "airport_description": "Perth",
        "latitude": "-31.940278",
        "longitude": "115.966944"
    },
    {
        "airport_name": "Pescara",
        "airport_code": "PSR",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Abruzzo Airport",
        "latitude": "42.4317",
        "longitude": "14.1811"
    },
    {
        "airport_name": "Peshawar",
        "airport_code": "PEW",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Bacha Khan International",
        "latitude": "34.033333",
        "longitude": "71.616667"
    },
    {
        "airport_name": "Phalaborwa",
        "airport_code": "PHW",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Phalaborwa Airport",
        "latitude": "-23.9372",
        "longitude": "31.1554"
    },
    {
        "airport_name": "Philadelphia",
        "airport_code": "PHL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Philadelphia International",
        "latitude": "39.871944",
        "longitude": "-75.241111"
    },
    {
        "airport_name": "Phnom Penh",
        "airport_code": "PNH",
        "country_name": "Cambodia",
        "country_code": "KH",
        "country_long_code": "KHM",
        "airport_description": "Phnom Penh International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Phoenix",
        "airport_code": "PHX",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Sky Harbor International",
        "latitude": "33.433333",
        "longitude": "-112.033333"
    },
    {
        "airport_name": "Phu Quoc",
        "airport_code": "PQC",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Phu Quoc International Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Phuket",
        "airport_code": "HKT",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Phuket International Airport",
        "latitude": "8.113333",
        "longitude": "98.316944"
    },
    {
        "airport_name": "Pietermaritzburg",
        "airport_code": "PZB",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Pietermaritzburg Airport",
        "latitude": "-29.649",
        "longitude": "30.3987"
    },
    {
        "airport_name": "Pisa",
        "airport_code": "PSA",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Galileo Galilei",
        "latitude": "43.683333",
        "longitude": "10.4"
    },
    {
        "airport_name": "Pittsburgh",
        "airport_code": "PIT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Pittsburgh International",
        "latitude": "40.491389",
        "longitude": "-80.232778"
    },
    {
        "airport_name": "Pleiku",
        "airport_code": "PXU",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Pleiku Airport",
        "latitude": "14.0045",
        "longitude": "108.0178"
    },
    {
        "airport_name": "Pocatello",
        "airport_code": "PIH",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Pocatello Regional Airport",
        "latitude": "42.9098",
        "longitude": "-112.5966"
    },
    {
        "airport_name": "Podgorica",
        "airport_code": "TGD",
        "country_name": "Montenegro",
        "country_code": "ME",
        "country_long_code": "MNE",
        "airport_description": "Podgorica Airport",
        "latitude": "42.3594",
        "longitude": "19.2519"
    },
    {
        "airport_name": "Pointe-Noire",
        "airport_code": "PNR",
        "country_name": "Congo Brazzaville",
        "country_code": "CG",
        "country_long_code": "",
        "airport_description": "Pointe-Noire",
        "latitude": "-4.816111",
        "longitude": "11.886667"
    },
    {
        "airport_name": "Polokwane",
        "airport_code": "PTG",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Polokwane International Airport",
        "latitude": "-23.9261",
        "longitude": "29.4844"
    },
    {
        "airport_name": "Pontianak",
        "airport_code": "PNK",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Supadio International Airport",
        "latitude": "-0.1507",
        "longitude": "109.4042"
    },
    {
        "airport_name": "Port Blair",
        "airport_code": "IXZ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Veer Savarkar International",
        "latitude": "11.666667",
        "longitude": "92.733333"
    },
    {
        "airport_name": "Port Elizabeth",
        "airport_code": "PLZ",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Port Elizabeth",
        "latitude": "-33.983333",
        "longitude": "25.616667"
    },
    {
        "airport_name": "Portland",
        "airport_code": "PDX",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Portland International",
        "latitude": "45.588611",
        "longitude": "-122.5975"
    },
    {
        "airport_name": "Porto",
        "airport_code": "OPO",
        "country_name": "Portugal",
        "country_code": "PT",
        "country_long_code": "PRT",
        "airport_description": "Francisco Sa Carneiro Airport",
        "latitude": "41.248056",
        "longitude": "-8.681389"
    },
    {
        "airport_name": "Porto Alegre",
        "airport_code": "POA",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Salgado Filho International Airport",
        "latitude": "-29.9944",
        "longitude": "-51.1714"
    },
    {
        "airport_name": "Porto Seguro",
        "airport_code": "BPS",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Porto Seguro Airport",
        "latitude": "-16.4386",
        "longitude": "-39.0809"
    },
    {
        "airport_name": "Posadas",
        "airport_code": "PSS",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Libertador General Jos\u00e9 de San Mart\u00edn Airport",
        "latitude": "-27.3858",
        "longitude": "-55.9707"
    },
    {
        "airport_name": "Pozna\u0144",
        "airport_code": "POZ",
        "country_name": "Poland",
        "country_code": "PL",
        "country_long_code": "POL",
        "airport_description": "Pozna\u0144\u2013\u0141awica Airport",
        "latitude": "52.421",
        "longitude": "16.8263"
    },
    {
        "airport_name": "Prague",
        "airport_code": "PRG",
        "country_name": "Czech Republic",
        "country_code": "CZ",
        "country_long_code": "CZE",
        "airport_description": "V\u00e1clav Havel Airport Prague",
        "latitude": "50.066667",
        "longitude": "14.433333"
    },
    {
        "airport_name": "Praya",
        "airport_code": "LOP",
        "country_name": "Cape Verde (Republic of)",
        "country_code": "CV",
        "country_long_code": "CPV",
        "airport_description": "Lombok International",
        "latitude": "-8.763199",
        "longitude": "116.272822"
    },
    {
        "airport_name": "Pristina",
        "airport_code": "PRN",
        "country_name": "Republic of Kosovo",
        "country_code": "XK",
        "country_long_code": "XKX",
        "airport_description": "Pristina International Airport Adem Jashari",
        "latitude": "42.5728",
        "longitude": "21.0358"
    },
    {
        "airport_name": "Puerto Escondido",
        "airport_code": "PXM",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Puerto Escondido International Airport",
        "latitude": "15.8769",
        "longitude": "-97.0891"
    },
    {
        "airport_name": "Puerto Iguaz\u00fa",
        "airport_code": "IGR",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Cataratas del Iguaz\u00fa International Airport",
        "latitude": "-25.7373",
        "longitude": "-54.4734"
    },
    {
        "airport_name": "Puerto Madryn",
        "airport_code": "PMY",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "El Tehuelche Airport",
        "latitude": "-42.7592",
        "longitude": "-65.1027"
    },
    {
        "airport_name": "Puerto Princesa",
        "airport_code": "PPS",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Puerto Princesa International Airport",
        "latitude": "9.733333",
        "longitude": "118.75"
    },
    {
        "airport_name": "Puerto Vallarta",
        "airport_code": "PVR",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Licenciado Gustavo D\u00edaz Ordaz International Airport",
        "latitude": "20.6801",
        "longitude": "-105.2541"
    },
    {
        "airport_name": "Pula",
        "airport_code": "PUY",
        "country_name": "Croatia",
        "country_code": "HR",
        "country_long_code": "HRV",
        "airport_description": "Pula Airport",
        "latitude": "44.8935",
        "longitude": "13.9222"
    },
    {
        "airport_name": "Pullman",
        "airport_code": "PUW",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Pullman\u2013Moscow Regional Airport",
        "latitude": "46.7439",
        "longitude": "-117.1094"
    },
    {
        "airport_name": "Pune",
        "airport_code": "PNQ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Lohegaon",
        "latitude": "18.583333",
        "longitude": "73.916667"
    },
    {
        "airport_name": "Punta del Este",
        "airport_code": "PDP",
        "country_name": "Uruguay",
        "country_code": "UY",
        "country_long_code": "URY",
        "airport_description": "Capit\u00e1n de Corbeta Carlos A. Curbelo International Airport",
        "latitude": "-34.8551",
        "longitude": "-54.9182"
    },
    {
        "airport_name": "Qaisumah",
        "airport_code": "AQI",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Hafar al Batin",
        "latitude": "28.316667",
        "longitude": "46.116667"
    },
    {
        "airport_name": "Qasigiannguit",
        "airport_code": "JGN",
        "country_name": "Greenland",
        "country_code": "GL",
        "country_long_code": "GRL",
        "airport_description": "Qaarsut Airport",
        "latitude": "39.8569",
        "longitude": "98.3416"
    },
    {
        "airport_name": "Qingdao",
        "airport_code": "TAO",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Qingdao Jiaodong International",
        "latitude": "36.1",
        "longitude": "120.316667"
    },
    {
        "airport_name": "Qinhuangdao",
        "airport_code": "QSZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Qinhuangdao Beidaihe Airport",
        "latitude": "38.4167",
        "longitude": "77.2167"
    },
    {
        "airport_name": "Qiqihar",
        "airport_code": "NDG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Qiqihar Sanjiazi",
        "latitude": "47.516667",
        "longitude": "112.133333"
    },
    {
        "airport_name": "Quanzhou",
        "airport_code": "JJN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Quanzhou Jinjiang International Airport",
        "latitude": "24.7964",
        "longitude": "118.5899"
    },
    {
        "airport_name": "Quer\u00e9taro",
        "airport_code": "QRO",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Quer\u00e9taro Intercontinental Airport",
        "latitude": "20.6173",
        "longitude": "-100.1857"
    },
    {
        "airport_name": "Quy Nhon",
        "airport_code": "UIH",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Phu Cat Airport",
        "latitude": "13.955",
        "longitude": "109.0422"
    },
    {
        "airport_name": "Quzhou",
        "airport_code": "JUZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Quzhou Airport",
        "latitude": "28.9658",
        "longitude": "118.8996"
    },
    {
        "airport_name": "Rabat",
        "airport_code": "RBA",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Sale",
        "latitude": "34.05",
        "longitude": "-6.75"
    },
    {
        "airport_name": "Rach Gia",
        "airport_code": "VKG",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Rach Gia Airport",
        "latitude": "9.958",
        "longitude": "105.1325"
    },
    {
        "airport_name": "Rafha",
        "airport_code": "RAH",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Rafha Airport",
        "latitude": "29.65",
        "longitude": "43.5"
    },
    {
        "airport_name": "Rahim yar khan",
        "airport_code": "RYK",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Rahim yar khan Shaikh Zayed International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Raipur",
        "airport_code": "RPR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Swami Vivekananda",
        "latitude": "21.183333",
        "longitude": "81.733333"
    },
    {
        "airport_name": "Rajkot",
        "airport_code": "RAJ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Rajkot Airport",
        "latitude": "22.3092",
        "longitude": "70.7795"
    },
    {
        "airport_name": "Rajshahi",
        "airport_code": "RJH",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Shah Makhdum",
        "latitude": "24.416667",
        "longitude": "88.508333"
    },
    {
        "airport_name": "Raleigh Durham",
        "airport_code": "RDU",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "International",
        "latitude": "35.877778",
        "longitude": "-78.7875"
    },
    {
        "airport_name": "Ranchi",
        "airport_code": "IXR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Birsa Munda Airport",
        "latitude": "23.3143",
        "longitude": "85.3216"
    },
    {
        "airport_name": "Rapid City",
        "airport_code": "RAP",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Rapid City Regional Airport",
        "latitude": "44.0453",
        "longitude": "-103.0574"
    },
    {
        "airport_name": "Rashkovsky",
        "airport_code": "RKZ",
        "country_name": "Ukraine",
        "country_code": "UA",
        "country_long_code": "UKR",
        "airport_description": "Rashkovsky Airport",
        "latitude": "29.3519",
        "longitude": "89.3114"
    },
    {
        "airport_name": "Rasht",
        "airport_code": "RZV",
        "country_name": "Iran",
        "country_code": "IR",
        "country_long_code": "IRN",
        "airport_description": "Rasht Airport",
        "latitude": "41.1756",
        "longitude": "40.8576"
    },
    {
        "airport_name": "Red Sea",
        "airport_code": "RSI",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Red Sea International Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Redmond",
        "airport_code": "RDM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Redmond Municipal Airport",
        "latitude": "44.2541",
        "longitude": "-121.15"
    },
    {
        "airport_name": "Reggio di Calabria",
        "airport_code": "REG",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Reggio Calabria",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Regina",
        "airport_code": "YQR",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Regina International Airport",
        "latitude": "50.43222",
        "longitude": "-104.66611"
    },
    {
        "airport_name": "Rennes",
        "airport_code": "RNS",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "St Jacques",
        "latitude": "48.066667",
        "longitude": "-1.733333"
    },
    {
        "airport_name": "Resistencia",
        "airport_code": "RES",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Resistencia International Airport",
        "latitude": "-27.449",
        "longitude": "-59.0561"
    },
    {
        "airport_name": "Reus",
        "airport_code": "REU",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Reus Airport",
        "latitude": "41.1474",
        "longitude": "1.1672"
    },
    {
        "airport_name": "Reykjav\u00edk",
        "airport_code": "REK",
        "country_name": "Iceland",
        "country_code": "IS",
        "country_long_code": "ISL",
        "airport_description": "Reykjav\u00edk Airport",
        "latitude": "63.985",
        "longitude": "-22.6056"
    },
    {
        "airport_name": "Rhinelander",
        "airport_code": "RHI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Rhinelander-Oneida County Airport",
        "latitude": "45.6312",
        "longitude": "-89.4675"
    },
    {
        "airport_name": "Rhodes",
        "airport_code": "RHO",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Rhodes International Airport",
        "latitude": "36.400833",
        "longitude": "28.083889"
    },
    {
        "airport_name": "R\u00edo Cuarto",
        "airport_code": "RCU",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Las Higueras Airport",
        "latitude": "-33.0851",
        "longitude": "-64.2613"
    },
    {
        "airport_name": "Rio de Janeiro",
        "airport_code": "GIG",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Ant\u00f4nio Carlos Jobim International Airport (Gale\u00e3o)",
        "latitude": "-22.808889",
        "longitude": "-43.243611"
    },
    {
        "airport_name": "Rio de Janeiro",
        "airport_code": "RIO",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Rio de Janeiro Metropolitan Area Airports",
        "latitude": "-22.8099",
        "longitude": "-43.2506"
    },
    {
        "airport_name": "R\u00edo Gallegos",
        "airport_code": "RGL",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Piloto Civil Norberto Fern\u00e1ndez International Airport",
        "latitude": "-51.6089",
        "longitude": "-69.3126"
    },
    {
        "airport_name": "Rio Grande",
        "airport_code": "RIZ",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Rio Grande Airport",
        "latitude": "35.405",
        "longitude": "119.324"
    },
    {
        "airport_name": "R\u00edo Grande",
        "airport_code": "RGA",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Hermes Quijada International Airport",
        "latitude": "-53.7777",
        "longitude": "-67.7494"
    },
    {
        "airport_name": "Riyadh",
        "airport_code": "RUH",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "King Khalid International",
        "latitude": "24.957778",
        "longitude": "46.698889"
    },
    {
        "airport_name": "Rochester",
        "airport_code": "ROC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Greater Rochester International Airport",
        "latitude": "43.118889",
        "longitude": "-77.6725"
    },
    {
        "airport_name": "Rochester",
        "airport_code": "RST",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Rochester International Airport",
        "latitude": "43.908333",
        "longitude": "-92.5"
    },
    {
        "airport_name": "Rome",
        "airport_code": "FCO",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Fiumicino",
        "latitude": "41.804444",
        "longitude": "12.250833"
    },
    {
        "airport_name": "Rome",
        "airport_code": "ROM",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Rome Metropolitan Area Airports",
        "latitude": "41.8003",
        "longitude": "12.2389"
    },
    {
        "airport_name": "R\u00f8nne (Bornholm)",
        "airport_code": "RNN",
        "country_name": "Denmark",
        "country_code": "DK",
        "country_long_code": "DNK",
        "airport_description": "Bornholm Airport",
        "latitude": "55.0633",
        "longitude": "14.7596"
    },
    {
        "airport_name": "Ronneby",
        "airport_code": "RNB",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Ronneby Airport",
        "latitude": "56.2667",
        "longitude": "15.265"
    },
    {
        "airport_name": "Rosario",
        "airport_code": "ROS",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Rosario \u2013 Islas Malvinas International Airport",
        "latitude": "-32.9036",
        "longitude": "-60.785"
    },
    {
        "airport_name": "Rostov",
        "airport_code": "ROV",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Platov International Airport",
        "latitude": "47.333333",
        "longitude": "39.7"
    },
    {
        "airport_name": "Roxas",
        "airport_code": "RXS",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Roxas Airport",
        "latitude": "11.516667",
        "longitude": "122.75"
    },
    {
        "airport_name": "Sabang",
        "airport_code": "SBG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Maimun Saleh Airport",
        "latitude": "5.8736",
        "longitude": "95.3397"
    },
    {
        "airport_name": "Sacramento",
        "airport_code": "SMF",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "International",
        "latitude": "38.7",
        "longitude": "-121.616667"
    },
    {
        "airport_name": "Saginaw",
        "airport_code": "MBS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "MBS International Airport",
        "latitude": "43.5329",
        "longitude": "-84.0796"
    },
    {
        "airport_name": "Saidpur",
        "airport_code": "SPD",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Saidpur Airport",
        "latitude": "25.7592",
        "longitude": "88.9086"
    },
    {
        "airport_name": "Saint Jhon",
        "airport_code": "YSJ",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Saint Jhon Airport\u00a0",
        "latitude": "45.316111",
        "longitude": "-65.890278"
    },
    {
        "airport_name": "Saint-Augustin",
        "airport_code": "YVA",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Saint-Augustin Airport",
        "latitude": "-11.5339",
        "longitude": "43.2719"
    },
    {
        "airport_name": "Salalah",
        "airport_code": "SLL",
        "country_name": "Oman",
        "country_code": "OM",
        "country_long_code": "OMN",
        "airport_description": "Salalah",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Salt Lake City",
        "airport_code": "SLC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Salt Lake City International",
        "latitude": "40.788333",
        "longitude": "-111.966667"
    },
    {
        "airport_name": "Salta",
        "airport_code": "SLA",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Mart\u00edn Miguel de G\u00fcemes International Airport",
        "latitude": "-24.855",
        "longitude": "-65.4862"
    },
    {
        "airport_name": "Salvador",
        "airport_code": "SSA",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Deputado Lu\u00eds Eduardo Magalh\u00e3es International Airport",
        "latitude": "-12.91",
        "longitude": "-38.331"
    },
    {
        "airport_name": "Salzburg",
        "airport_code": "SZG",
        "country_name": "Austria",
        "country_code": "AT",
        "country_long_code": "AUT",
        "airport_description": "Salzburg Airport",
        "latitude": "48.110278",
        "longitude": "16.569722"
    },
    {
        "airport_name": "Samara",
        "airport_code": "KUF",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Kurumoch International Airport",
        "latitude": "53.5049",
        "longitude": "50.1643"
    },
    {
        "airport_name": "Samos",
        "airport_code": "SMI",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Samos International Airport ",
        "latitude": "37.689",
        "longitude": "26.9123"
    },
    {
        "airport_name": "Samsun",
        "airport_code": "SZF",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Carsamba Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Samui",
        "airport_code": "USM",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Samui Airport",
        "latitude": "9.55",
        "longitude": "100.066667"
    },
    {
        "airport_name": "San Antonio",
        "airport_code": "SAT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "San Antonio International\u00a0Airport",
        "latitude": "29.533333",
        "longitude": "-98.466667"
    },
    {
        "airport_name": "San Carlos de Bariloche",
        "airport_code": "BRC",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Teniente Luis Candelaria International Airport",
        "latitude": "-41.1512",
        "longitude": "-71.1575"
    },
    {
        "airport_name": "San Diego",
        "airport_code": "SAN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "International",
        "latitude": "32.733333",
        "longitude": "-117.183333"
    },
    {
        "airport_name": "San Fernando del Valle de Catamarca",
        "airport_code": "CTC",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Coronel Felipe Varela International Airport",
        "latitude": "-28.5956",
        "longitude": "-65.7516"
    },
    {
        "airport_name": "San Francisco",
        "airport_code": "SFO",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "San Francisco International",
        "latitude": "37.618889",
        "longitude": "-122.375"
    },
    {
        "airport_name": "San Jose",
        "airport_code": "SJC",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "San Jose Municipal",
        "latitude": "37.352778",
        "longitude": "-121.919444"
    },
    {
        "airport_name": "San Luis",
        "airport_code": "LUQ",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Brigadier Mayor C\u00e9sar Ra\u00fal Ojeda Airport",
        "latitude": "-33.2732",
        "longitude": "-66.3564"
    },
    {
        "airport_name": "San Luis Potos\u00ed",
        "airport_code": "SLP",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Ponciano Arriaga International Airport",
        "latitude": "22.2543",
        "longitude": "-100.9302"
    },
    {
        "airport_name": "San Mart\u00edn de los Andes",
        "airport_code": "CPC",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Aviador Carlos Campos Airport",
        "latitude": "-40.0754",
        "longitude": "-71.1373"
    },
    {
        "airport_name": "San Miguel de Tucum\u00e1n",
        "airport_code": "TUC",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Teniente General Benjam\u00edn Matienzo International Airport",
        "latitude": "-26.8409",
        "longitude": "-65.1049"
    },
    {
        "airport_name": "San Rafael",
        "airport_code": "AFA",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Suboficial Ayudante Santiago Germano Airport",
        "latitude": "-34.5883",
        "longitude": "-68.4039"
    },
    {
        "airport_name": "San Salvador de Jujuy",
        "airport_code": "JUJ",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Gobernador Horacio Guzm\u00e1n International Airport",
        "latitude": "-24.3928",
        "longitude": "-65.0978"
    },
    {
        "airport_name": "San Sebasti\u00e1n",
        "airport_code": "EAS",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "San Sebasti\u00e1n Airport (Fuenterrab\u00eda)",
        "latitude": "43.3565",
        "longitude": "-1.7906"
    },
    {
        "airport_name": "Sandefjord",
        "airport_code": "TRF",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Sandefjord Airport, Torp",
        "latitude": "59.1867",
        "longitude": "10.2586"
    },
    {
        "airport_name": "Sanliurfa",
        "airport_code": "GNY",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Guney Anadolu",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Sanming",
        "airport_code": "SQJ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Sanming Shaxian Airport",
        "latitude": "26.4268",
        "longitude": "117.8456"
    },
    {
        "airport_name": "Santa Ana",
        "airport_code": "SNA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "John Wayne Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Santa Cruz",
        "airport_code": "SRZ",
        "country_name": "Bolivia",
        "country_code": "BO",
        "country_long_code": "BOL",
        "airport_description": "El Trompillo Airport",
        "latitude": "-17.8116",
        "longitude": "-63.1715"
    },
    {
        "airport_name": "Santa Cruz de la Palma",
        "airport_code": "SPC",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "La Palma",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Santa Cruz de la Sierra",
        "airport_code": "VVI",
        "country_name": "Bolivia",
        "country_code": "BO",
        "country_long_code": "BOL",
        "airport_description": "Viru Viru International Airport",
        "latitude": "-17.6448",
        "longitude": "-63.1354"
    },
    {
        "airport_name": "Santa Fe",
        "airport_code": "SFN",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Sauce Viejo Airport",
        "latitude": "-31.7117",
        "longitude": "-60.8117"
    },
    {
        "airport_name": "Santa Rosa",
        "airport_code": "RSA",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Santa Rosa Airport",
        "latitude": "-36.5883",
        "longitude": "-64.2757"
    },
    {
        "airport_name": "Santander",
        "airport_code": "SDR",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Santander Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Santiago de Chile",
        "airport_code": "SCL",
        "country_name": "Chile",
        "country_code": "CL",
        "country_long_code": "CHL",
        "airport_description": "Comodoro Arturo Merino Benitez International Airport",
        "latitude": "-33.559722",
        "longitude": "-70.7"
    },
    {
        "airport_name": "Santiago de Compostela",
        "airport_code": "SCQ",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Santiago de Compostela",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Santiago de Compostela",
        "airport_code": "SCO",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Santiago de Compostela Airport",
        "latitude": "43.8601",
        "longitude": "51.091"
    },
    {
        "airport_name": "Santiago del Estero",
        "airport_code": "SDE",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Vicecomodoro \u00c1ngel de la Paz Aragon\u00e9s Airport",
        "latitude": "-27.7656",
        "longitude": "-64.3092"
    },
    {
        "airport_name": "Sanya",
        "airport_code": "SYX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Sanya Phoenix International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Sao Paulo",
        "airport_code": "GRU",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "Guarulhos International Airport",
        "latitude": "-23.431944",
        "longitude": "-46.469444"
    },
    {
        "airport_name": "S\u00e3o Paulo",
        "airport_code": "SAO",
        "country_name": "Brazil",
        "country_code": "BR",
        "country_long_code": "BRA",
        "airport_description": "S\u00e3o Paulo Metropolitan Area Airports",
        "latitude": "-23.6261",
        "longitude": "-46.6566"
    },
    {
        "airport_name": "Sapporo",
        "airport_code": "CTS",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "New Chitose Airport",
        "latitude": "42.7875818",
        "longitude": "141.6781117"
    },
    {
        "airport_name": "Sapporo",
        "airport_code": "SPK",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "New Chitose Airport",
        "latitude": "42.7752",
        "longitude": "141.6923"
    },
    {
        "airport_name": "Sarajevo",
        "airport_code": "SJJ",
        "country_name": "Bosnia and Herzegovina",
        "country_code": "BA",
        "country_long_code": "BIH",
        "airport_description": "Sarajevo International",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Saskatoon",
        "airport_code": "YXE",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "J.G Diefenbaker International Airport",
        "latitude": "52.170834",
        "longitude": "-106.699722"
    },
    {
        "airport_name": "Satu Mare",
        "airport_code": "SUJ",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Satu Mare Airport",
        "latitude": "47.7033",
        "longitude": "22.8857"
    },
    {
        "airport_name": "Sault Ste Marie",
        "airport_code": "YAM",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Sault Ste Marie Airport",
        "latitude": "46.485001",
        "longitude": "-84.509445"
    },
    {
        "airport_name": "Saumlaki",
        "airport_code": "TTE",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Olilit Airport",
        "latitude": "0.8314",
        "longitude": "127.3809"
    },
    {
        "airport_name": "Scampton (RAF)",
        "airport_code": "SCR",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "RAF Scampton (military)",
        "latitude": "62.0486",
        "longitude": "17.4521"
    },
    {
        "airport_name": "Seattle",
        "airport_code": "SEA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Seattle Tacoma International",
        "latitude": "47.448889",
        "longitude": "-122.309444"
    },
    {
        "airport_name": "Semarang",
        "airport_code": "SRG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Ahmad Yani",
        "latitude": "-6.983333",
        "longitude": "110.383333"
    },
    {
        "airport_name": "Seoul",
        "airport_code": "ICN",
        "country_name": "South Korea",
        "country_code": "KR",
        "country_long_code": "KOR",
        "airport_description": "Incheon International",
        "latitude": "37.469167",
        "longitude": "126.450556"
    },
    {
        "airport_name": "Seoul",
        "airport_code": "SEL",
        "country_name": "South Korea",
        "country_code": "KR",
        "country_long_code": "KOR",
        "airport_description": "Seoul Metropolitan Area Airports",
        "latitude": "37.4602",
        "longitude": "126.4407"
    },
    {
        "airport_name": "Seoul",
        "airport_code": "GMP",
        "country_name": "South Korea",
        "country_code": "KR",
        "country_long_code": "KOR",
        "airport_description": "Gimpo International Airport",
        "latitude": "37.5583",
        "longitude": "126.7906"
    },
    {
        "airport_name": "Sevilla",
        "airport_code": "SVQ",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Sevilla Airport",
        "latitude": "37.433333",
        "longitude": "-5.9"
    },
    {
        "airport_name": "Seychelles",
        "airport_code": "SEZ",
        "country_name": "Seychelles Islands",
        "country_code": "SC",
        "country_long_code": "SYC",
        "airport_description": "Seychelles International Airport",
        "latitude": "-4.674444",
        "longitude": "55.521944"
    },
    {
        "airport_name": "Shanghai",
        "airport_code": "PVG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Pudong International",
        "latitude": "31.143333",
        "longitude": "121.805278"
    },
    {
        "airport_name": "Shanghai",
        "airport_code": "SHA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "HONGQIAO INTL Airport",
        "latitude": "31.2",
        "longitude": "121.341111"
    },
    {
        "airport_name": "Shangrao",
        "airport_code": "SQD",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Shangrao Sanqingshan Airport",
        "latitude": "28.3797",
        "longitude": "117.9646"
    },
    {
        "airport_name": "Shannon",
        "airport_code": "SNN",
        "country_name": "Iceland",
        "country_code": "IS",
        "country_long_code": "ISL",
        "airport_description": "Shannon Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Shantou",
        "airport_code": "SWA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Jieyang Chaoshan International Airport",
        "latitude": "23.5525",
        "longitude": "116.5033"
    },
    {
        "airport_name": "Sharm El Sheikh",
        "airport_code": "SSH",
        "country_name": "Egypt",
        "country_code": "EG",
        "country_long_code": "EGY",
        "airport_description": "Sharm El Sheikh International",
        "latitude": "27.977222",
        "longitude": "34.395"
    },
    {
        "airport_name": "Sharurah",
        "airport_code": "SHW",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Sharurah Airport",
        "latitude": "17.416667",
        "longitude": "47.1"
    },
    {
        "airport_name": "Shashi",
        "airport_code": "SHS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Shashi Airport",
        "latitude": "31.56",
        "longitude": "110.344"
    },
    {
        "airport_name": "Shenyang",
        "airport_code": "SHE",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Shenyang Taoxian International",
        "latitude": "41.871667",
        "longitude": "123.433333"
    },
    {
        "airport_name": "Shenzhen",
        "airport_code": "SZX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Shenzhen Bao'an International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Shijiazhuang",
        "airport_code": "SJW",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Shijiazhuang Zhengding International Airport",
        "latitude": "38.2807",
        "longitude": "114.696"
    },
    {
        "airport_name": "Shiquanhe",
        "airport_code": "NGQ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Ngari Gunsa Airport",
        "latitude": "32.1002",
        "longitude": "80.0534"
    },
    {
        "airport_name": "Shiyan",
        "airport_code": "WDS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Shiyan Wudangshan Airport",
        "latitude": "32.5907",
        "longitude": "110.9075"
    },
    {
        "airport_name": "Shizuoka",
        "airport_code": "FSZ",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Shizuoka Airport",
        "latitude": "34.7961",
        "longitude": "138.1894"
    },
    {
        "airport_name": "Siauliai",
        "airport_code": "SXZ",
        "country_name": "Lithuania",
        "country_code": "LT",
        "country_long_code": "LTU",
        "airport_description": "Siauliai International Airport",
        "latitude": "37.9781",
        "longitude": "41.8404"
    },
    {
        "airport_name": "Sibu",
        "airport_code": "SBW",
        "country_name": "Malaysia",
        "country_code": "MY",
        "country_long_code": "MYS",
        "airport_description": "Sibu Airport",
        "latitude": "2.333333",
        "longitude": "111.833333"
    },
    {
        "airport_name": "Sicogon Island",
        "airport_code": "ICO",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Sicogon Airport",
        "latitude": "11.4352",
        "longitude": "123.2405"
    },
    {
        "airport_name": "Siem Reap",
        "airport_code": "REP",
        "country_name": "Cambodia",
        "country_code": "KH",
        "country_long_code": "KHM",
        "airport_description": "Siem Reap\u2013Angkor International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Sihanoukville",
        "airport_code": "SAI",
        "country_name": "Cambodia",
        "country_code": "KH",
        "country_long_code": "KHM",
        "airport_description": "Sihanoukville International Airport",
        "latitude": "13.4107",
        "longitude": "103.8131"
    },
    {
        "airport_name": "Silchar",
        "airport_code": "IXS",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Silchar Airport",
        "latitude": "24.9096",
        "longitude": "92.9787"
    },
    {
        "airport_name": "Simao",
        "airport_code": "SYM",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Pu'er Simao Airport",
        "latitude": "22.7934",
        "longitude": "100.9598"
    },
    {
        "airport_name": "Singapore",
        "airport_code": "SIN",
        "country_name": "Singapore",
        "country_code": "SG",
        "country_long_code": "SGP",
        "airport_description": "Changi",
        "latitude": "1.350278",
        "longitude": "103.994444"
    },
    {
        "airport_name": "Sinop",
        "airport_code": "NOP",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Sinop",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Sirnak",
        "airport_code": "NKT",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Sirnak",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Sivas",
        "airport_code": "VAS",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Sivas",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Skellefte\u00e5",
        "airport_code": "SFT",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Skellefte\u00e5 Airport",
        "latitude": "64.6248",
        "longitude": "21.0769"
    },
    {
        "airport_name": "Skopje",
        "airport_code": "SKP",
        "country_name": "North Macedonia",
        "country_code": "MK",
        "country_long_code": "MKD",
        "airport_description": "Skopje International Airport",
        "latitude": "41.9616",
        "longitude": "21.6214"
    },
    {
        "airport_name": "Sochi",
        "airport_code": "AER",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Sochi International Airport",
        "latitude": "43.4499",
        "longitude": "39.9566"
    },
    {
        "airport_name": "Sofia",
        "airport_code": "SOF",
        "country_name": "Bulgaria",
        "country_code": "BG",
        "country_long_code": "BGR",
        "airport_description": "Sofia",
        "latitude": "42.7",
        "longitude": "23.4"
    },
    {
        "airport_name": "Sorong",
        "airport_code": "SOQ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Domine Eduard Osok Airport",
        "latitude": "-0.9272",
        "longitude": "131.121"
    },
    {
        "airport_name": "South Bend",
        "airport_code": "SBN",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "South Bend International Airport",
        "latitude": "41.7087",
        "longitude": "-86.3173"
    },
    {
        "airport_name": "Southampton",
        "airport_code": "SOU",
        "country_name": "United Kingdom",
        "country_code": "GB",
        "country_long_code": "GBR",
        "airport_description": "Southampton Airport",
        "latitude": "50.9503",
        "longitude": "-1.3568"
    },
    {
        "airport_name": "Split",
        "airport_code": "SPU",
        "country_name": "Croatia",
        "country_code": "HR",
        "country_long_code": "HRV",
        "airport_description": "Split Airport",
        "latitude": "43.533333",
        "longitude": "16.3"
    },
    {
        "airport_name": "Spokane",
        "airport_code": "GEG",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Spokane International Airport",
        "latitude": "47.619722",
        "longitude": "-117.533889"
    },
    {
        "airport_name": "Srinagar",
        "airport_code": "SXR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Sheikh ul-Alam International Airport",
        "latitude": "33.9871",
        "longitude": "74.7742"
    },
    {
        "airport_name": "St Jhon's",
        "airport_code": "YYT",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "St Jhon's International Airport",
        "latitude": "47.61861",
        "longitude": "-52.751945"
    },
    {
        "airport_name": "St Petersburg",
        "airport_code": "LED",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Pulkovo",
        "latitude": "59.95",
        "longitude": "30.05"
    },
    {
        "airport_name": "St. George",
        "airport_code": "SGU",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "St. George Regional Airport",
        "latitude": "37.0364",
        "longitude": "-113.5103"
    },
    {
        "airport_name": "St. George's",
        "airport_code": "GND",
        "country_name": "Grenada",
        "country_code": "GD",
        "country_long_code": "GRD",
        "airport_description": "Maurice Bishop International Airport",
        "latitude": "12.0042",
        "longitude": "-61.7862"
    },
    {
        "airport_name": "St. Louis",
        "airport_code": "STL",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Lambert-Saint Louis International Airport",
        "latitude": "38.748611",
        "longitude": "-90.37"
    },
    {
        "airport_name": "Stavanger",
        "airport_code": "SVG",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Stavanger Airport, Sola",
        "latitude": "58.8768",
        "longitude": "5.6378"
    },
    {
        "airport_name": "Stockholm",
        "airport_code": "STO",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Stockholm Arlanda Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Stockholm",
        "airport_code": "ARN",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Stockholm Arlanda Airport",
        "latitude": "59.6519",
        "longitude": "17.9186"
    },
    {
        "airport_name": "Strasbourg",
        "airport_code": "SXB",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Entzheim",
        "latitude": "48.583333",
        "longitude": "7.633333"
    },
    {
        "airport_name": "Stuttgart",
        "airport_code": "STR",
        "country_name": "Germany",
        "country_code": "DE",
        "country_long_code": "DEU",
        "airport_description": "Stuttgart Airport",
        "latitude": "48.683333",
        "longitude": "9.2"
    },
    {
        "airport_name": "Suceava",
        "airport_code": "SCV",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Suceava \u0218tefan cel Mare Airport",
        "latitude": "47.6875",
        "longitude": "26.3541"
    },
    {
        "airport_name": "Sudbury",
        "airport_code": "YSB",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Sudbury Airport",
        "latitude": "46.625",
        "longitude": "\u00a0-80.798889"
    },
    {
        "airport_name": "Sukhothai",
        "airport_code": "THS",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Sukhothai Airport",
        "latitude": "17.237",
        "longitude": "99.8182"
    },
    {
        "airport_name": "Sukkur",
        "airport_code": "SKZ",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Sukkur Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Sulaymaniyah",
        "airport_code": "ISU",
        "country_name": "Iraq",
        "country_code": "IQ",
        "country_long_code": "IRQ",
        "airport_description": "Sulaymaniyah International Airport",
        "latitude": "35.5616",
        "longitude": "45.3171"
    },
    {
        "airport_name": "Sundsvall",
        "airport_code": "SDL",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Sundsvall\u2013Timr\u00e5 Airport",
        "latitude": "62.5281",
        "longitude": "17.4439"
    },
    {
        "airport_name": "Surabaya",
        "airport_code": "SUB",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Juanda",
        "latitude": "-7.379722",
        "longitude": "112.786944"
    },
    {
        "airport_name": "Surakarta (Solo)",
        "airport_code": "SOC",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Adi Sumarmo",
        "latitude": "-7.5",
        "longitude": "110.75"
    },
    {
        "airport_name": "Surat",
        "airport_code": "STV",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Surat Airport",
        "latitude": "21.1141",
        "longitude": "72.7411"
    },
    {
        "airport_name": "Sydney",
        "airport_code": "SYD",
        "country_name": "Australia",
        "country_code": "AU",
        "country_long_code": "AUS",
        "airport_description": "Kingsford Smith",
        "latitude": "-33.946111",
        "longitude": "151.177222"
    },
    {
        "airport_name": "Sydney",
        "airport_code": "YQY",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "J.A Douglas Mcurdy Airport",
        "latitude": "46.161388",
        "longitude": "-60.047779"
    },
    {
        "airport_name": "Sylhet",
        "airport_code": "ZYL",
        "country_name": "Bangladesh",
        "country_code": "BD",
        "country_long_code": "BGD",
        "airport_description": "Osmani International",
        "latitude": "24.95",
        "longitude": "91.866667"
    },
    {
        "airport_name": "Tabuk",
        "airport_code": "TUU",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Prince Sultan Bin Abdulaziz Airport",
        "latitude": "28.383333",
        "longitude": "36.583333"
    },
    {
        "airport_name": "Tacheng",
        "airport_code": "TCZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Tacheng Airport",
        "latitude": "25.0361",
        "longitude": "98.4837"
    },
    {
        "airport_name": "Tacheng",
        "airport_code": "TCG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Tacheng Airport",
        "latitude": "46.6725",
        "longitude": "83.3408"
    },
    {
        "airport_name": "Tacloban",
        "airport_code": "TAC",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Daniel Z. Romualdez Airport",
        "latitude": "11.233333",
        "longitude": "125.016667"
    },
    {
        "airport_name": "Tagbilaran",
        "airport_code": "TAG",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Tagbilaran Airport",
        "latitude": "9.666667",
        "longitude": "123.85"
    },
    {
        "airport_name": "Taichung",
        "airport_code": "RMQ",
        "country_name": "Taiwan",
        "country_code": "TW",
        "country_long_code": "TWN",
        "airport_description": "Taichung International Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Taif",
        "airport_code": "TIF",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Taif Airport",
        "latitude": "21.270278",
        "longitude": "40.415833"
    },
    {
        "airport_name": "Taipei",
        "airport_code": "TSA",
        "country_name": "Taiwan",
        "country_code": "TW",
        "country_long_code": "TWN",
        "airport_description": "Taipei Songshan Airport",
        "latitude": "25.0694",
        "longitude": "121.5525"
    },
    {
        "airport_name": "Taipei, Taiwan",
        "airport_code": "TPE",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Taiwan Taoyuan International Airport",
        "latitude": "25.077778",
        "longitude": "121.223889"
    },
    {
        "airport_name": "Taiyuan",
        "airport_code": "TYN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Taiyuan Wusu International Airport",
        "latitude": "37.7469",
        "longitude": "112.627"
    },
    {
        "airport_name": "Takamatsu",
        "airport_code": "TAK",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Takamatsu Airport",
        "latitude": "34.2142",
        "longitude": "134.0165"
    },
    {
        "airport_name": "Tallinn",
        "airport_code": "TLL",
        "country_name": "Estonia",
        "country_code": "EE",
        "country_long_code": "EST",
        "airport_description": "Lennart Meri Tallinn Airport",
        "latitude": "59.4133",
        "longitude": "24.8328"
    },
    {
        "airport_name": "Tampa",
        "airport_code": "TPA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Tampa International Airport",
        "latitude": "27.975556",
        "longitude": "-82.533056"
    },
    {
        "airport_name": "Tampico",
        "airport_code": "TAM",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Francisco Javier Mina International Airport",
        "latitude": "22.2964",
        "longitude": "-97.8659"
    },
    {
        "airport_name": "Tangier",
        "airport_code": "TNG",
        "country_name": "Morocco",
        "country_code": "MA",
        "country_long_code": "MAR",
        "airport_description": "Ibn Batouta",
        "latitude": "35.731944",
        "longitude": "-5.901667"
    },
    {
        "airport_name": "Tanjung Pinang",
        "airport_code": "TNJ",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Raja Haji Fisabilillah Airport",
        "latitude": "0.9227",
        "longitude": "104.5322"
    },
    {
        "airport_name": "Tapachula",
        "airport_code": "TAP",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Tapachula International Airport",
        "latitude": "14.7943",
        "longitude": "-92.37"
    },
    {
        "airport_name": "Tbilisi",
        "airport_code": "TBS",
        "country_name": "Georgia",
        "country_code": "GE",
        "country_long_code": "GEO",
        "airport_description": "International",
        "latitude": "41.669167",
        "longitude": "44.954722"
    },
    {
        "airport_name": "Tehran",
        "airport_code": "THR",
        "country_name": "Iran",
        "country_code": "IR",
        "country_long_code": "IRN",
        "airport_description": "Mehrabad International",
        "latitude": "35.689167",
        "longitude": "51.313333"
    },
    {
        "airport_name": "Tenerife",
        "airport_code": "TFS",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Tenerife South Airport",
        "latitude": "28.0445",
        "longitude": "-16.5725"
    },
    {
        "airport_name": "Tenerife",
        "airport_code": "TCI",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Tenerife Airport",
        "latitude": "28.482778",
        "longitude": "-16.341667"
    },
    {
        "airport_name": "Tepic",
        "airport_code": "TPQ",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Amado Nervo National Airport",
        "latitude": "21.4195",
        "longitude": "-104.8426"
    },
    {
        "airport_name": "Termas de R\u00edo Hondo",
        "airport_code": "RHD",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Termas de R\u00edo Hondo International Airport",
        "latitude": "-27.4966",
        "longitude": "-64.9351"
    },
    {
        "airport_name": "Thanh Hoa",
        "airport_code": "THD",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Tho Xuan Airport",
        "latitude": "19.9017",
        "longitude": "105.4678"
    },
    {
        "airport_name": "Thessaloniki",
        "airport_code": "SKG",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Thessaloniki Airport",
        "latitude": "40.519722",
        "longitude": "22.970833"
    },
    {
        "airport_name": "Thira",
        "airport_code": "JTR",
        "country_name": "Greece",
        "country_code": "GR",
        "country_long_code": "GRC",
        "airport_description": "Santorini\u00a0(Thira)\u00a0International Airport",
        "latitude": "36.4",
        "longitude": "25.483333"
    },
    {
        "airport_name": "Thiruvananthapuram",
        "airport_code": "TRV",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Thiruvananthapuram International Airport",
        "latitude": "8.482222",
        "longitude": "76.92"
    },
    {
        "airport_name": "Thunder Bay",
        "airport_code": "YQT",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Thunder Bay International Airport",
        "latitude": "48.371944",
        "longitude": "-89.323889"
    },
    {
        "airport_name": "Tianjin",
        "airport_code": "TSN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Tianjin Binhai International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Tijuana",
        "airport_code": "TIJ",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Tijuana International Airport",
        "latitude": "32.5411",
        "longitude": "-116.9702"
    },
    {
        "airport_name": "Timika",
        "airport_code": "TIM",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Mozes Kilangin Airport",
        "latitude": "-4.5283",
        "longitude": "136.8874"
    },
    {
        "airport_name": "Timi\u0219oara",
        "airport_code": "TSR",
        "country_name": "Romania",
        "country_code": "RO",
        "country_long_code": "ROM",
        "airport_description": "Timi\u0219oara Traian Vuia International Airport",
        "latitude": "45.8099",
        "longitude": "21.3379"
    },
    {
        "airport_name": "Timmins",
        "airport_code": "YTS",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Victor M. Power Airport",
        "latitude": "48.569721",
        "longitude": "-81.376667"
    },
    {
        "airport_name": "Tirana",
        "airport_code": "TIA",
        "country_name": "Albania",
        "country_code": "AL",
        "country_long_code": "ALB",
        "airport_description": "Nene Tereza International",
        "latitude": "41.414722",
        "longitude": "19.720556"
    },
    {
        "airport_name": "Tirupati",
        "airport_code": "TIR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Tirupati Airport",
        "latitude": "13.6325",
        "longitude": "79.5433"
    },
    {
        "airport_name": "Tivat",
        "airport_code": "TIV",
        "country_name": "Montenegro",
        "country_code": "ME",
        "country_long_code": "MNE",
        "airport_description": "Tivat Airport",
        "latitude": "42.4047",
        "longitude": "18.7233"
    },
    {
        "airport_name": "Tocoa",
        "airport_code": "TOJ",
        "country_name": "Honduras",
        "country_code": "HN",
        "country_long_code": "HND",
        "airport_description": "Tocoa Airport",
        "latitude": "40.4989",
        "longitude": "-3.4459"
    },
    {
        "airport_name": "Tokat",
        "airport_code": "TJK",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Tokat Airport",
        "latitude": "40.3076",
        "longitude": "36.3676"
    },
    {
        "airport_name": "Tokoname",
        "airport_code": "NGO",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Chubu Centrair International\u00a0Airport",
        "latitude": "34.858333",
        "longitude": "136.805278"
    },
    {
        "airport_name": "Tokyo",
        "airport_code": "HND",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Tokyo Haneda Airport",
        "latitude": "35.5493975",
        "longitude": "139.7772637"
    },
    {
        "airport_name": "Tokyo",
        "airport_code": "NRT",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "Tokyo Narita International Airport",
        "latitude": "35.763889",
        "longitude": "140.391667"
    },
    {
        "airport_name": "Tokyo",
        "airport_code": "TYO",
        "country_name": "Japan",
        "country_code": "JP",
        "country_long_code": "JPN",
        "airport_description": "All Airports",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Tonghua",
        "airport_code": "TNH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Tonghua Sanyuanpu Airport",
        "latitude": "41.1034",
        "longitude": "125.6972"
    },
    {
        "airport_name": "Tongliao",
        "airport_code": "TGO",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Tongliao Airport",
        "latitude": "43.5567",
        "longitude": "122.1994"
    },
    {
        "airport_name": "Tongren",
        "airport_code": "TEN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Tongren Fenghuang Airport",
        "latitude": "27.8838",
        "longitude": "109.308"
    },
    {
        "airport_name": "Toronto",
        "airport_code": "YYZ",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Toronto Pearson International Airport",
        "latitude": "43.677222",
        "longitude": "-79.630556"
    },
    {
        "airport_name": "Toronto",
        "airport_code": "YTO",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Toronto Metropolitan Area Airports",
        "latitude": "43.6777",
        "longitude": "-79.6248"
    },
    {
        "airport_name": "Torre\u00f3n",
        "airport_code": "TRC",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Torre\u00f3n International Airport",
        "latitude": "25.5683",
        "longitude": "-103.4119"
    },
    {
        "airport_name": "T\u00f3rshavn (Faroe Islands)",
        "airport_code": "FAE",
        "country_name": "Faroe Islands",
        "country_code": "FO",
        "country_long_code": "FRO",
        "airport_description": "V\u00e1gar Airport",
        "latitude": "62.0636",
        "longitude": "-7.2772"
    },
    {
        "airport_name": "Toulouse",
        "airport_code": "TLS",
        "country_name": "France",
        "country_code": "FR",
        "country_long_code": "FRA",
        "airport_description": "Blagnac",
        "latitude": "43.635",
        "longitude": "1.367778"
    },
    {
        "airport_name": "Trabzon",
        "airport_code": "TZX",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Trabzon",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Trat",
        "airport_code": "TDX",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "Trat Airport",
        "latitude": "12.2746",
        "longitude": "102.3199"
    },
    {
        "airport_name": "Trelew",
        "airport_code": "REL",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Almirante Marcos A. Zar Airport",
        "latitude": "-43.2105",
        "longitude": "-65.2703"
    },
    {
        "airport_name": "Tri-Cities",
        "airport_code": "TRI",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Tri-Cities Regional Airport",
        "latitude": "36.4752",
        "longitude": "-82.4074"
    },
    {
        "airport_name": "Tripoli",
        "airport_code": "TIP",
        "country_name": "Libya",
        "country_code": "LY",
        "country_long_code": "LBY",
        "airport_description": "Tripoli International",
        "latitude": "32.669444",
        "longitude": "13.156667"
    },
    {
        "airport_name": "Trondheim",
        "airport_code": "TRD",
        "country_name": "Norway",
        "country_code": "NO",
        "country_long_code": "NOR",
        "airport_description": "Trondheim Airport, V\u00e6rnes",
        "latitude": "63.4578",
        "longitude": "10.924"
    },
    {
        "airport_name": "Tunis",
        "airport_code": "TUN",
        "country_name": "Tunisia",
        "country_code": "TN",
        "country_long_code": "TUN",
        "airport_description": "Carthage",
        "latitude": "36.853611",
        "longitude": "10.228611"
    },
    {
        "airport_name": "Turaif",
        "airport_code": "TUI",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Turaif Airport",
        "latitude": "27.133333",
        "longitude": "44.1"
    },
    {
        "airport_name": "Turbat",
        "airport_code": "TUK",
        "country_name": "Pakistan",
        "country_code": "PK",
        "country_long_code": "PAK",
        "airport_description": "Turbat International Airport",
        "latitude": "33.616667",
        "longitude": "73.1"
    },
    {
        "airport_name": "Turin",
        "airport_code": "TRN",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Caselle",
        "latitude": "45.200833",
        "longitude": "7.649722"
    },
    {
        "airport_name": "Turku",
        "airport_code": "TKU",
        "country_name": "Finland",
        "country_code": "FI",
        "country_long_code": "FIN",
        "airport_description": "Turku Airport",
        "latitude": "60.5141",
        "longitude": "22.2628"
    },
    {
        "airport_name": "Tuxtla Guti\u00e9rrez",
        "airport_code": "TGZ",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "\u00c1ngel Albino Corzo International Airport",
        "latitude": "16.5636",
        "longitude": "-93.0226"
    },
    {
        "airport_name": "Tuy Hoa",
        "airport_code": "TBB",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Dong Tac Airport",
        "latitude": "13.0496",
        "longitude": "109.3333"
    },
    {
        "airport_name": "Twin Falls",
        "airport_code": "TWF",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Joslin Field \u2013 Magic Valley Regional Airport",
        "latitude": "42.4818",
        "longitude": "-114.4877"
    },
    {
        "airport_name": "Udaipur",
        "airport_code": "UDR",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Maharana Pratap",
        "latitude": "24.616667",
        "longitude": "73.883333"
    },
    {
        "airport_name": "Ufa",
        "airport_code": "UFA",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Ufa International Airport",
        "latitude": "54.5575",
        "longitude": "55.8744"
    },
    {
        "airport_name": "Ulsan",
        "airport_code": "USN",
        "country_name": "South Korea",
        "country_code": "KR",
        "country_long_code": "KOR",
        "airport_description": "Ulsan Airport",
        "latitude": "6.233333",
        "longitude": "-10.366667"
    },
    {
        "airport_name": "Ume\u00e5",
        "airport_code": "UME",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Ume\u00e5 Airport",
        "latitude": "63.7918",
        "longitude": "20.2828"
    },
    {
        "airport_name": "Umtata",
        "airport_code": "UTT",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Mthatha Airport",
        "latitude": "-31.5464",
        "longitude": "28.6743"
    },
    {
        "airport_name": "Upington",
        "airport_code": "UTN",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Upington Airport",
        "latitude": "-28.3991",
        "longitude": "21.2602"
    },
    {
        "airport_name": "\u00dcr\u00fcmqi",
        "airport_code": "URC",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "\u00dcr\u00fcmqi Diwopu International Airport",
        "latitude": "43.9071",
        "longitude": "87.4742"
    },
    {
        "airport_name": "Ushuaia",
        "airport_code": "USH",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Ushuaia \u2013 Malvinas Argentinas International Airport",
        "latitude": "-54.8433",
        "longitude": "-68.2958"
    },
    {
        "airport_name": "U-Taphao",
        "airport_code": "UTP",
        "country_name": "Thailand",
        "country_code": "TH",
        "country_long_code": "THA",
        "airport_description": "U-Taphao International Airport",
        "latitude": "12.6799",
        "longitude": "101.004"
    },
    {
        "airport_name": "Vaasa",
        "airport_code": "VAA",
        "country_name": "Finland",
        "country_code": "FI",
        "country_long_code": "FIN",
        "airport_description": "Vaasa Airport",
        "latitude": "63.0507",
        "longitude": "21.7622"
    },
    {
        "airport_name": "Valdosta",
        "airport_code": "VLD",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Valdosta Regional Airport",
        "latitude": "30.7825",
        "longitude": "-83.2767"
    },
    {
        "airport_name": "Valencia",
        "airport_code": "VLC",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Valencia Airport",
        "latitude": "39.489444",
        "longitude": "-0.481667"
    },
    {
        "airport_name": "Valladolid",
        "airport_code": "VLL",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Valladolid Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Van",
        "airport_code": "VAN",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Ferit Melen",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Van Don",
        "airport_code": "VDO",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Van Don International Airport",
        "latitude": "21.12",
        "longitude": "107.414"
    },
    {
        "airport_name": "Vancouver",
        "airport_code": "YVR",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Vancouver International",
        "latitude": "49.193889",
        "longitude": "-123.183333"
    },
    {
        "airport_name": "Varanasi",
        "airport_code": "VNS",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Lal Bahadur Shastri Airport",
        "latitude": "25.4524",
        "longitude": "82.8593"
    },
    {
        "airport_name": "Varna",
        "airport_code": "VAR",
        "country_name": "Bulgaria",
        "country_code": "BG",
        "country_long_code": "BGR",
        "airport_description": "Varna Airport",
        "latitude": "43.2321",
        "longitude": "27.8251"
    },
    {
        "airport_name": "V\u00e4xj\u00f6",
        "airport_code": "VXO",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "V\u00e4xj\u00f6 Sm\u00e5land Airport",
        "latitude": "56.9291",
        "longitude": "14.728"
    },
    {
        "airport_name": "Venice",
        "airport_code": "VCE",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Marco Polo",
        "latitude": "45.505278",
        "longitude": "12.351944"
    },
    {
        "airport_name": "Veracruz",
        "airport_code": "VER",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Heriberto Jara International Airport",
        "latitude": "19.1459",
        "longitude": "-96.1873"
    },
    {
        "airport_name": "Verona",
        "airport_code": "VRN",
        "country_name": "Italy",
        "country_code": "IT",
        "country_long_code": "ITA",
        "airport_description": "Villafranca",
        "latitude": "45.466667",
        "longitude": "10.933333"
    },
    {
        "airport_name": "Victoria",
        "airport_code": "YYJ",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Victoria International Airport",
        "latitude": "48.6469",
        "longitude": "123.4258"
    },
    {
        "airport_name": "Victoria Falls",
        "airport_code": "VFA",
        "country_name": "South Africa",
        "country_code": "ZA",
        "country_long_code": "ZAF",
        "airport_description": "Victoria Falls Airport",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Vidalia",
        "airport_code": "VDE",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Vidalia Regional Airport",
        "latitude": "27.8148",
        "longitude": "-17.8871"
    },
    {
        "airport_name": "Viedma",
        "airport_code": "VDM",
        "country_name": "Argentina",
        "country_code": "AR",
        "country_long_code": "ARG",
        "airport_description": "Gobernador Edgardo Castello Airport",
        "latitude": "-40.8692",
        "longitude": "-63.0004"
    },
    {
        "airport_name": "Vienna",
        "airport_code": "VIE",
        "country_name": "Austria",
        "country_code": "AT",
        "country_long_code": "AUT",
        "airport_description": "Vienna International",
        "latitude": "48.110278",
        "longitude": "16.569722"
    },
    {
        "airport_name": "Vientiane",
        "airport_code": "VTE",
        "country_name": "Lao (People's Democratic Republic)",
        "country_code": "LA",
        "country_long_code": "LAO",
        "airport_description": "Wattay International Airport",
        "latitude": "30.578611",
        "longitude": "103.947222"
    },
    {
        "airport_name": "Vigo",
        "airport_code": "VGO",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Vigo Airport",
        "latitude": "42.216667",
        "longitude": "-8.616667"
    },
    {
        "airport_name": "Vijayawada",
        "airport_code": "VGA",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Vijayawada Airport",
        "latitude": "16.5304",
        "longitude": "80.7968"
    },
    {
        "airport_name": "Villahermosa",
        "airport_code": "VSA",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "Carlos Rovirosa P\u00e9rez International Airport",
        "latitude": "17.995",
        "longitude": "-92.8174"
    },
    {
        "airport_name": "Vilnius",
        "airport_code": "VNO",
        "country_name": "Lithuania",
        "country_code": "LT",
        "country_long_code": "LTU",
        "airport_description": "Vilnius International Airport",
        "latitude": "54.6341",
        "longitude": "25.2858"
    },
    {
        "airport_name": "Vinh",
        "airport_code": "VII",
        "country_name": "Vietnam",
        "country_code": "VN",
        "country_long_code": "VNM",
        "airport_description": "Vinh International Airport",
        "latitude": "18.7376",
        "longitude": "105.6708"
    },
    {
        "airport_name": "Visakhapatnam",
        "airport_code": "VTZ",
        "country_name": "India",
        "country_code": "IN",
        "country_long_code": "IND",
        "airport_description": "Visakhapatnam International Airport",
        "latitude": "12.961389",
        "longitude": "74.89"
    },
    {
        "airport_name": "Visby",
        "airport_code": "VBY",
        "country_name": "Sweden",
        "country_code": "SE",
        "country_long_code": "SWE",
        "airport_description": "Visby Airport",
        "latitude": "57.6628",
        "longitude": "18.3462"
    },
    {
        "airport_name": "Vitoria-Gasteiz",
        "airport_code": "VIT",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Vitoria Airport",
        "latitude": "42.8828",
        "longitude": "-2.7245"
    },
    {
        "airport_name": "Voronezh",
        "airport_code": "VOZ",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Voronezh International Airport",
        "latitude": "51.8142",
        "longitude": "39.2296"
    },
    {
        "airport_name": "Wadi Al Dawaser",
        "airport_code": "WAE",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Wadi Al Dawaser",
        "latitude": "20.5",
        "longitude": "45.166667"
    },
    {
        "airport_name": "Wanzhou",
        "airport_code": "WXN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Chongqing Wanzhou Wuqiao Airport",
        "latitude": "30.8017",
        "longitude": "108.433"
    },
    {
        "airport_name": "Warsaw",
        "airport_code": "WAW",
        "country_name": "Poland",
        "country_code": "PL",
        "country_long_code": "POL",
        "airport_description": "Frederic Chopin",
        "latitude": "52.166667",
        "longitude": "20.966667"
    },
    {
        "airport_name": "Washington D.C",
        "airport_code": "WAS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "All Airports",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Washington, D.C.",
        "airport_code": "DCA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "R Reagan National",
        "latitude": "38.851944",
        "longitude": "-77.037778"
    },
    {
        "airport_name": "Washington, DC",
        "airport_code": "IAD",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Dulles International",
        "latitude": "38.944444",
        "longitude": "-77.455833"
    },
    {
        "airport_name": "Weifang",
        "airport_code": "WEF",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Weifang Nanyuan Airport",
        "latitude": "36.6467",
        "longitude": "119.1191"
    },
    {
        "airport_name": "Weihai",
        "airport_code": "WEH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Weihai Dashuibo Airport",
        "latitude": "37.1871",
        "longitude": "122.2288"
    },
    {
        "airport_name": "Wenzhou",
        "airport_code": "WNZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Wenzhou Longwan International Airport",
        "latitude": "27.9122",
        "longitude": "120.8526"
    },
    {
        "airport_name": "West Columbia",
        "airport_code": "CAE",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Columbia Metropolitan Airport",
        "latitude": "33.95",
        "longitude": "-81.116667"
    },
    {
        "airport_name": "West Yellowstone",
        "airport_code": "WYS",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Yellowstone Airport",
        "latitude": "44.6884",
        "longitude": "-111.1176"
    },
    {
        "airport_name": "Wichita",
        "airport_code": "ICT",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Wichita Dwight D. Eisenhower National Airport",
        "latitude": "37.65",
        "longitude": "-97.433333"
    },
    {
        "airport_name": "Williston",
        "airport_code": "XWA",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Williston Basin International Airport",
        "latitude": "48.2582",
        "longitude": "-103.7477"
    },
    {
        "airport_name": "Windhoek",
        "airport_code": "WDH",
        "country_name": "Namibia",
        "country_code": "NA",
        "country_long_code": "NAM",
        "airport_description": "Hosea Kutako International Airport",
        "latitude": "-22.4847",
        "longitude": "17.4709"
    },
    {
        "airport_name": "Windsor",
        "airport_code": "YQG",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "Windsor Airport",
        "latitude": "42.275556",
        "longitude": "-82.955556"
    },
    {
        "airport_name": "Winnipeg",
        "airport_code": "YWG",
        "country_name": "Canada",
        "country_code": "CA",
        "country_long_code": "CAN",
        "airport_description": "James Armstrong Richardson International Airport",
        "latitude": "49.910036",
        "longitude": "-97.239886"
    },
    {
        "airport_name": "Wuhai",
        "airport_code": "WUA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Wuhai Airport",
        "latitude": "39.7946",
        "longitude": "106.7994"
    },
    {
        "airport_name": "Wuhai",
        "airport_code": "WHA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Wuhai Airport",
        "latitude": "31.3906",
        "longitude": "118.4088"
    },
    {
        "airport_name": "Wuhan",
        "airport_code": "WUH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Wuhan Tianhe International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Wutung",
        "airport_code": "WUT",
        "country_name": "Papua New Guinea",
        "country_code": "PG",
        "country_long_code": "PNG",
        "airport_description": "Wutung Airport",
        "latitude": "30.6581",
        "longitude": "118.7361"
    },
    {
        "airport_name": "Wuxi",
        "airport_code": "WUX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Sunan Shuofang International Airport",
        "latitude": "31.4944",
        "longitude": "120.4294"
    },
    {
        "airport_name": "Wuyishan",
        "airport_code": "WUS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Wuyishan Airport",
        "latitude": "27.7019",
        "longitude": "118.0003"
    },
    {
        "airport_name": "Xiamen",
        "airport_code": "XMN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xiamen Gaoqi International",
        "latitude": "24.466667",
        "longitude": "118.116667"
    },
    {
        "airport_name": "Xi'an",
        "airport_code": "XIY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xi'an Xianyang International",
        "latitude": "34.447222",
        "longitude": "108.751667"
    },
    {
        "airport_name": "Xichang",
        "airport_code": "XIC",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xichang Qingshan Airport",
        "latitude": "27.9891",
        "longitude": "102.1836"
    },
    {
        "airport_name": "Xilinhot",
        "airport_code": "XIL",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xilinhot Airport",
        "latitude": "43.9156",
        "longitude": "115.9637"
    },
    {
        "airport_name": "Xingyi",
        "airport_code": "ACX",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xingyi Airport",
        "latitude": "25.0882",
        "longitude": "104.9593"
    },
    {
        "airport_name": "Xinyang",
        "airport_code": "XAI",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xinyang Minggang Airport",
        "latitude": "32.54",
        "longitude": "114.078"
    },
    {
        "airport_name": "Xuzhou",
        "airport_code": "XUZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Xuzhou Guanyin Airport",
        "latitude": "34.0581",
        "longitude": "117.5553"
    },
    {
        "airport_name": "Yakima",
        "airport_code": "YKM",
        "country_name": "United States of America",
        "country_code": "US",
        "country_long_code": "USA",
        "airport_description": "Yakima Air Terminal",
        "latitude": "46.5682",
        "longitude": "-120.544"
    },
    {
        "airport_name": "Yan'an",
        "airport_code": "ENY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yan'an Nanniwan Airport",
        "latitude": "36.6362",
        "longitude": "109.5547"
    },
    {
        "airport_name": "Yanbu",
        "airport_code": "YNB",
        "country_name": "Saudi Arabia",
        "country_code": "SA",
        "country_long_code": "SAU",
        "airport_description": "Prince Abdul Mohsin bin Abdulaziz International Airport",
        "latitude": "24.083333",
        "longitude": "38.05"
    },
    {
        "airport_name": "Yancheng",
        "airport_code": "YNZ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yancheng Nanyang International Airport",
        "latitude": "33.4344",
        "longitude": "120.2036"
    },
    {
        "airport_name": "Yangon",
        "airport_code": "RGN",
        "country_name": null,
        "country_code": null,
        "country_long_code": null,
        "airport_description": "Yangon International Airport",
        "latitude": "16.852778",
        "longitude": "96.133333"
    },
    {
        "airport_name": "Yangzhou",
        "airport_code": "YTY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yangzhou Taizhou International Airport",
        "latitude": "32.5617",
        "longitude": "119.715"
    },
    {
        "airport_name": "Yanji",
        "airport_code": "YNJ",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yanji Chaoyangchuan International Airport",
        "latitude": "-22.833333",
        "longitude": "-43.25"
    },
    {
        "airport_name": "Yantai",
        "airport_code": "YNT",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yantai Penglai International Airport",
        "latitude": "37.4017",
        "longitude": "121.3725"
    },
    {
        "airport_name": "Yaounde",
        "airport_code": "NSI",
        "country_name": "Cameroon (Republic of)",
        "country_code": "CM",
        "country_long_code": "CMR",
        "airport_description": "Yaound\u00e9 Nsimalen International Airport",
        "latitude": "3.7225",
        "longitude": "11.553333"
    },
    {
        "airport_name": "Yaound\u00e9",
        "airport_code": "YIA",
        "country_name": "Cameroon (Republic of)",
        "country_code": "CM",
        "country_long_code": "CMR",
        "airport_description": "Yaound\u00e9 Nsimalen International Airport",
        "latitude": "-7.9053",
        "longitude": "110.0567"
    },
    {
        "airport_name": "Yekaterinburg",
        "airport_code": "SVX",
        "country_name": "Russia",
        "country_code": "RU",
        "country_long_code": "RUS",
        "airport_description": "Koltsovo International Airport",
        "latitude": "56.7431",
        "longitude": "60.8027"
    },
    {
        "airport_name": "Yerevan",
        "airport_code": "EVN",
        "country_name": "Armenia",
        "country_code": "AM",
        "country_long_code": "ARM",
        "airport_description": "Zvartnots International",
        "latitude": "",
        "longitude": ""
    },
    {
        "airport_name": "Yibin",
        "airport_code": "YBP",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yibin Wuliangye Airport",
        "latitude": "28.8003",
        "longitude": "104.5454"
    },
    {
        "airport_name": "Yichang",
        "airport_code": "YIH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yichang Sanxia",
        "latitude": "30.7",
        "longitude": "111.183333"
    },
    {
        "airport_name": "Yinchuan",
        "airport_code": "INC",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yinchuan Hedong International",
        "latitude": "38.366667",
        "longitude": "106.366667"
    },
    {
        "airport_name": "Yining",
        "airport_code": "YIN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yining Airport",
        "latitude": "43.9558",
        "longitude": "81.3303"
    },
    {
        "airport_name": "Yogyakarta",
        "airport_code": "JOG",
        "country_name": "Indonesia",
        "country_code": "ID",
        "country_long_code": "IDN",
        "airport_description": "Adisutjipto",
        "latitude": "-7.783333",
        "longitude": "110.433333"
    },
    {
        "airport_name": "Yulin",
        "airport_code": "UYN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yulin Yuyang Airport",
        "latitude": "38.2692",
        "longitude": "109.7314"
    },
    {
        "airport_name": "Yuncheng",
        "airport_code": "YCU",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yuncheng Guangong Airport",
        "latitude": "35.1164",
        "longitude": "111.0311"
    },
    {
        "airport_name": "Yushu",
        "airport_code": "YUS",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Yushu Batang Airport",
        "latitude": "32.8369",
        "longitude": "97.0367"
    },
    {
        "airport_name": "Zacatecas",
        "airport_code": "ZCL",
        "country_name": "Mexico",
        "country_code": "MX",
        "country_long_code": "MEX",
        "airport_description": "General Leobardo C. Ruiz International Airport",
        "latitude": "22.8971",
        "longitude": "-102.686"
    },
    {
        "airport_name": "Zadar",
        "airport_code": "ZAD",
        "country_name": "Croatia",
        "country_code": "HR",
        "country_long_code": "HRV",
        "airport_description": "Zadar Airport",
        "latitude": "44.1083",
        "longitude": "15.3467"
    },
    {
        "airport_name": "Zagreb",
        "airport_code": "ZAG",
        "country_name": "Croatia",
        "country_code": "HR",
        "country_long_code": "HRV",
        "airport_description": "Franjo Tudman ",
        "latitude": "45.733333",
        "longitude": "16.066667"
    },
    {
        "airport_name": "Zamboanga",
        "airport_code": "ZAM",
        "country_name": "Philippines",
        "country_code": "PH",
        "country_long_code": "PHL",
        "airport_description": "Zamboanga International Airport",
        "latitude": "6.933333",
        "longitude": "122.066667"
    },
    {
        "airport_name": "Zanzibar",
        "airport_code": "ZNZ",
        "country_name": "Tanzania (United Republic)",
        "country_code": "TZ",
        "country_long_code": "TZA",
        "airport_description": "Zanzibar International Airport",
        "latitude": "-6.216667",
        "longitude": "39.216667"
    },
    {
        "airport_name": "Zaporizhzhia",
        "airport_code": "OZH",
        "country_name": "Ukraine",
        "country_code": "UA",
        "country_long_code": "UKR",
        "airport_description": "Zaporizhzhia International Airport",
        "latitude": "47.867",
        "longitude": "35.3157"
    },
    {
        "airport_name": "Zaqatala",
        "airport_code": "ZQZ",
        "country_name": "Azerbaijan",
        "country_code": "AZ",
        "country_long_code": "AZE",
        "airport_description": "Zaqatala Airport",
        "latitude": "40.7388",
        "longitude": "114.9308"
    },
    {
        "airport_name": "Zaragoza",
        "airport_code": "ZAZ",
        "country_name": "Spain",
        "country_code": "ES",
        "country_long_code": "ESP",
        "airport_description": "Zaragoza Airport",
        "latitude": "41.6666",
        "longitude": "-0.888"
    },
    {
        "airport_name": "Zhangjiajie",
        "airport_code": "DYG",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhangjiajie Hehua International Airport",
        "latitude": "29.1034",
        "longitude": "110.4438"
    },
    {
        "airport_name": "Zhangxian",
        "airport_code": "HXD",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhangxian Airport",
        "latitude": "37.1253",
        "longitude": "97.2622"
    },
    {
        "airport_name": "Zhanjiang",
        "airport_code": "ZHA",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhanjiang Wuchuan Airport",
        "latitude": "21.2144",
        "longitude": "110.3581"
    },
    {
        "airport_name": "Zhaotong",
        "airport_code": "ZAT",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhaotong Airport",
        "latitude": "27.3256",
        "longitude": "103.7554"
    },
    {
        "airport_name": "Zhayrem",
        "airport_code": "YZY",
        "country_name": "Kazakhstan",
        "country_code": "KZ",
        "country_long_code": "KAZ",
        "airport_description": "Zhayrem Airport",
        "latitude": "38.8",
        "longitude": "100.6772"
    },
    {
        "airport_name": "Zhengzhou",
        "airport_code": "CGO",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhengzhou Xinzheng International Airport",
        "latitude": "34.5197",
        "longitude": "113.8402"
    },
    {
        "airport_name": "Zhoushan",
        "airport_code": "HSN",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhoushan Putuoshan Airport",
        "latitude": "29.9342",
        "longitude": "122.3625"
    },
    {
        "airport_name": "Zhoushan",
        "airport_code": "ZHY",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhoushan Putuoshan Airport",
        "latitude": "37.5728",
        "longitude": "105.1545"
    },
    {
        "airport_name": "Zhuhai",
        "airport_code": "ZUH",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zhuhai Jinwan Airport",
        "latitude": "22.0064",
        "longitude": "113.3758"
    },
    {
        "airport_name": "Zonguldak",
        "airport_code": "ONQ",
        "country_name": "Turkey",
        "country_code": "TR",
        "country_long_code": "TUR",
        "airport_description": "Zonguldak \u00c7aycuma Airport",
        "latitude": "41.5064",
        "longitude": "32.0886"
    },
    {
        "airport_name": "Zunyi",
        "airport_code": "ZYI",
        "country_name": "China",
        "country_code": "CN",
        "country_long_code": "CHN",
        "airport_description": "Zunyi Xinzhou Airport",
        "latitude": "27.5895",
        "longitude": "107.0005"
    },
    {
        "airport_name": "Zurich",
        "airport_code": "ZRH",
        "country_name": "Switzerland",
        "country_code": "CH",
        "country_long_code": "CHE",
        "airport_description": "Zurich Airport",
        "latitude": "47.464722",
        "longitude": "8.549167"
    }
];


for $air in $airports {
    create airport content {
        code: $air.airport_code,
        name: $air.airport_name,
        description: $air.airport_description,
        country_name: $air.country_name,
        country_code: $air.country_code,
        country_long_code: $air.country_long_code,
        latitude: $air.latitude,
        longitude: $air.longitude
    };
};

let $jobs = [
    {
        "english_name": "Head of Non-Profit Organization",
        "arabic_name": "رئيس منظمة غير ربحية",
        "code": "111401"
    },
    {
        "english_name": "Chamber of Commerce and Industry President",
        "arabic_name": "رئيس غرفة تجارة وصناعة",
        "code": "111402"
    },
    {
        "english_name": "Federation President",
        "arabic_name": "رئيس اتحاد",
        "code": "111403"
    },
    {
        "english_name": "Secretary-General of an Organization with Special Interests",
        "arabic_name": "أمين عام منظمة ذات اهتمامات خاصة",
        "code": "111404"
    },
    {
        "english_name": "Chief Executive Officer",
        "arabic_name": "رئيس تنفيذي",
        "code": "112001"
    },
    {
        "english_name": "Chairman",
        "arabic_name": "رئيس مجلس إدارة",
        "code": "112002"
    },
    {
        "english_name": "Regional Manger",
        "arabic_name": "مدير إقليمي",
        "code": "112003"
    },
    {
        "english_name": "General Manager",
        "arabic_name": "مدير عام",
        "code": "112004"
    },
    {
        "english_name": "Head of Public Authority",
        "arabic_name": "رئيس هيئة عامة",
        "code": "112005"
    },
    {
        "english_name": "Corporate President",
        "arabic_name": "رئيس شركة",
        "code": "112006"
    },
    {
        "english_name": "Partner Manager",
        "arabic_name": "مدير شريك",
        "code": "112007"
    },
    {
        "english_name": "‎Branch Manager",
        "arabic_name": "مدير فرع",
        "code": "112008"
    },
    {
        "english_name": "Investor",
        "arabic_name": "مستثمر",
        "code": "112009"
    },
    {
        "english_name": "Chief Information Security Officer",
        "arabic_name": "رئيس أمن سيبراني",
        "code": "112010"
    },
    {
        "english_name": "Financial Manager",
        "arabic_name": "مدير مالي",
        "code": "121101"
    },
    {
        "english_name": "Account Manager",
        "arabic_name": "مدير حسابات",
        "code": "121102"
    },
    {
        "english_name": "Tariff Accounting Manager",
        "arabic_name": "مدير حسابات تعريفة",
        "code": "121103"
    },
    {
        "english_name": "Cash Treasury Manager",
        "arabic_name": "مدير خزينة",
        "code": "121104"
    },
    {
        "english_name": "Budget Manager",
        "arabic_name": "مدير ميزانية",
        "code": "121105"
    },
    {
        "english_name": "Audit Manager",
        "arabic_name": "مدير مراجعة",
        "code": "121106"
    },
    {
        "english_name": "Internal Audit Manager",
        "arabic_name": "مدير مراجعة داخلية",
        "code": "121107"
    },
    {
        "english_name": "Property Valuation Manager",
        "arabic_name": "مدير تقييم عقاري",
        "code": "121108"
    },
    {
        "english_name": "Insurance Services Manager",
        "arabic_name": "مدير خدمات تأمين",
        "code": "121109"
    },
    {
        "english_name": "Investment Manager",
        "arabic_name": "مدير استثمار",
        "code": "121110"
    },
    {
        "english_name": "Banking Services Manager",
        "arabic_name": "مدير خدمات بنكية",
        "code": "121111"
    },
    {
        "english_name": "Credit Manager",
        "arabic_name": "مدير ائتمان",
        "code": "121112"
    },
    {
        "english_name": "Collection Manager",
        "arabic_name": "مدير تحصيل",
        "code": "121113"
    },
    {
        "english_name": "Trading Manager",
        "arabic_name": "مدير تداول",
        "code": "121114"
    },
    {
        "english_name": "Financial brokerage Manager",
        "arabic_name": "مدير وساطة مالية",
        "code": "121115"
    },
    {
        "english_name": "Treasury Manager",
        "arabic_name": "مدير خزانة",
        "code": "121116"
    },
    {
        "english_name": "Statistics Manager",
        "arabic_name": "مدير إحصاء",
        "code": "121117"
    },
    {
        "english_name": "Actuarial Manager",
        "arabic_name": "مدير إكتواري",
        "code": "121118"
    },
    {
        "english_name": "Human Resources Operation Manager",
        "arabic_name": "مدير عمليات موارد بشرية",
        "code": "121201"
    },
    {
        "english_name": "Labor Force Planning Manager",
        "arabic_name": "مدير تخطيط قوى عاملة",
        "code": "121202"
    },
    {
        "english_name": "Professions Classification Manager",
        "arabic_name": "مدير تصنيف مهن",
        "code": "121203"
    },
    {
        "english_name": "Recruitment Manager",
        "arabic_name": "مدير توظيف",
        "code": "121204"
    },
    {
        "english_name": "Compensations Manager",
        "arabic_name": "مدير تعويضات",
        "code": "121205"
    },
    {
        "english_name": "Talent Manager",
        "arabic_name": "مدير مواهب",
        "code": "121206"
    },
    {
        "english_name": "Human Resources Development Manager",
        "arabic_name": "مدير تطوير موارد بشرية",
        "code": "121207"
    },
    {
        "english_name": "Individual Relationship Manager",
        "arabic_name": "مدير علاقات الأفراد",
        "code": "121208"
    },
    {
        "english_name": "Recruitment Office Manager",
        "arabic_name": "مدير مكتب استقدام",
        "code": "121209"
    },
    {
        "english_name": "Labor Office Manager",
        "arabic_name": "مدير مكتب عمل",
        "code": "121210"
    },
    {
        "english_name": "Labor Affairs Manager",
        "arabic_name": "مدير شؤون عمل",
        "code": "121211"
    },
    {
        "english_name": "Civil Service Office Manager",
        "arabic_name": "مدير مكتب خدمة مدنية",
        "code": "121212"
    },
    {
        "english_name": "Institutional Development Manager",
        "arabic_name": "مدير تطوير مؤسسي",
        "code": "121213"
    },
    {
        "english_name": "Administrative Organization Manager",
        "arabic_name": "مدير تنظيم إداري",
        "code": "121214"
    },
    {
        "english_name": "Administrative Investigation Manager",
        "arabic_name": "مدير تحقيق إداري",
        "code": "121215"
    },
    {
        "english_name": "Cybersecurity HR Manager",
        "arabic_name": "مدير موارد بشرية أمن سيبراني",
        "code": "121216"
    },
    {
        "english_name": "Economic Development Manager",
        "arabic_name": "مدير تنمية اقتصادية",
        "code": "121301"
    },
    {
        "english_name": "Risk-Management Manager",
        "arabic_name": "مدير إدارة مخاطر",
        "code": "121302"
    },
    {
        "english_name": "Compliance Manager",
        "arabic_name": "مدير التزام",
        "code": "121303"
    },
    {
        "english_name": "Quality Manager",
        "arabic_name": "مدير جودة",
        "code": "121304"
    },
    {
        "english_name": "Trading Market Control Manager",
        "arabic_name": "مدير رقابة أسواق تجارية",
        "code": "121305"
    },
    {
        "english_name": "Customer Protection Manager",
        "arabic_name": "مدير حماية مستهلكين",
        "code": "121306"
    },
    {
        "english_name": "Investor Protection Manager",
        "arabic_name": "مدير حماية مستثمر",
        "code": "121307"
    },
    {
        "english_name": "Financial Services Control Manager",
        "arabic_name": "مدير رقابة خدمات مالية",
        "code": "121308"
    },
    {
        "english_name": "License and Permit Manager",
        "arabic_name": "مدير تراخيص وتصاريح",
        "code": "121309"
    },
    {
        "english_name": "Planning and Development Manager",
        "arabic_name": "مدير تخطيط وتطوير",
        "code": "121310"
    },
    {
        "english_name": "Strategic Planning Manager",
        "arabic_name": "مدير تخطيط إستراتيجي",
        "code": "121311"
    },
    {
        "english_name": "Institutional Policy Manager",
        "arabic_name": "مدير سياسات مؤسسية",
        "code": "121312"
    },
    {
        "english_name": "Institutional Performance and Follow up Manager",
        "arabic_name": "مدير متابعة وأداء مؤسسي",
        "code": "121313"
    },
    {
        "english_name": "Project Management Manager",
        "arabic_name": "مدير إدارة مشاريع",
        "code": "121314"
    },
    {
        "english_name": "Administrative Control Manager",
        "arabic_name": "مدير رقابة ادارية",
        "code": "121315"
    },
    {
        "english_name": "Office Manager",
        "arabic_name": "مدير مكتب",
        "code": "121901"
    },
    {
        "english_name": "Administrative Manger",
        "arabic_name": "مدير إداري",
        "code": "121902"
    },
    {
        "english_name": "Secretary of Council",
        "arabic_name": "أمين مجلس",
        "code": "121903"
    },
    {
        "english_name": "Common Service Manager",
        "arabic_name": "مدير خدمات مشتركة",
        "code": "121904"
    },
    {
        "english_name": "Business Manager",
        "arabic_name": "مدير تجاري",
        "code": "122101"
    },
    {
        "english_name": "Customer Services Manager",
        "arabic_name": "مدير خدمة العملاء",
        "code": "122102"
    },
    {
        "english_name": "Marketing Manager",
        "arabic_name": "مدير تسويق",
        "code": "122103"
    },
    {
        "english_name": "Sales Manager",
        "arabic_name": "مدير مبيعات",
        "code": "122104"
    },
    {
        "english_name": "Contract Manager",
        "arabic_name": "مدير عقود",
        "code": "122105"
    },
    {
        "english_name": "Advertising Manager",
        "arabic_name": "مدير دعاية وإعلان",
        "code": "122201"
    },
    {
        "english_name": "International Relationship Manager",
        "arabic_name": "مدير علاقات دولية",
        "code": "122202"
    },
    {
        "english_name": "Public Relations Manager",
        "arabic_name": "مدير علاقات عامة",
        "code": "122203"
    },
    {
        "english_name": "Customer Account Manager",
        "arabic_name": "مدير حساب عميل",
        "code": "122204"
    },
    {
        "english_name": "Fundraising Manager",
        "arabic_name": "مدير جمع التبرعات",
        "code": "122205"
    },
    {
        "english_name": "Protocols Manager",
        "arabic_name": "مدير مراسم",
        "code": "122206"
    },
    {
        "english_name": "Research & Development Manager",
        "arabic_name": "مدير بحث وتطوير",
        "code": "122301"
    },
    {
        "english_name": "Product Development Manager",
        "arabic_name": "مدير تطوير المنتجات",
        "code": "122302"
    },
    {
        "english_name": "Research Studies Manager",
        "arabic_name": "مدير دراسات أبحاث",
        "code": "122303"
    },
    {
        "english_name": "Agricultural Affairs Manager",
        "arabic_name": "مدير شؤون زراعية",
        "code": "131101"
    },
    {
        "english_name": "Irrigation Manager",
        "arabic_name": "مدير شؤون ري",
        "code": "131102"
    },
    {
        "english_name": "Pastures & Forests Affairs Manager",
        "arabic_name": "مدير شؤون مراعي وغابات",
        "code": "131103"
    },
    {
        "english_name": "Livestock Affairs Manager",
        "arabic_name": "مدير شؤون ثروة حيوانية",
        "code": "131104"
    },
    {
        "english_name": "Animal farm Manager",
        "arabic_name": "مدير مزرعة حيوانات",
        "code": "131105"
    },
    {
        "english_name": "Slaughterhouse Manager",
        "arabic_name": "مدير مسلخ",
        "code": "131106"
    },
    {
        "english_name": "Apiary Manager",
        "arabic_name": "مدير منحل",
        "code": "131107"
    },
    {
        "english_name": "Crop Farm Manager",
        "arabic_name": "مدير مزرعة محاصيل",
        "code": "131108"
    },
    {
        "english_name": "Nursery Manager",
        "arabic_name": "مدير مشتل",
        "code": "131109"
    },
    {
        "english_name": "Fishery Affairs Manager",
        "arabic_name": "مدير شؤون ثروة سمكية",
        "code": "131201"
    },
    {
        "english_name": "Fish Farm Manager",
        "arabic_name": "مدير مزرعة سمكية",
        "code": "131202"
    },
    {
        "english_name": "Crustacean Farm Manager",
        "arabic_name": "مدير مزرعة قشريات",
        "code": "131203"
    },
    {
        "english_name": "Manufacturing Manager",
        "arabic_name": "مدير تصنيع",
        "code": "132101"
    },
    {
        "english_name": "Industrial Production Manager",
        "arabic_name": "مدير إنتاج صناعي",
        "code": "132102"
    },
    {
        "english_name": "Factory Manager",
        "arabic_name": "مدير مصنع",
        "code": "132103"
    },
    {
        "english_name": "Maintenance Manager",
        "arabic_name": "مدير صيانة",
        "code": "132104"
    },
    {
        "english_name": "Oil Refining Manager",
        "arabic_name": "مدير تكرير نفط",
        "code": "132105"
    },
    {
        "english_name": "Water Desalination Plant Manager",
        "arabic_name": "مدير محطة تحلية مياه",
        "code": "132106"
    },
    {
        "english_name": "Water Treatment Plant Manager",
        "arabic_name": "مدير محطة معالجة مياه",
        "code": "132107"
    },
    {
        "english_name": "Power Plant Manager",
        "arabic_name": "مدير محطة توليد طاقة",
        "code": "132108"
    },
    {
        "english_name": "Industrial Engineering Operations Manager",
        "arabic_name": "مدير عمليات هندسة صناعية",
        "code": "132109"
    },
    {
        "english_name": "Electrical Engineering Operations Manager",
        "arabic_name": "مدير عمليات هندسة كهربائية",
        "code": "132110"
    },
    {
        "english_name": "Mechanical Engineering Operations Manager",
        "arabic_name": "مدير عمليات هندسة ميكانيكية",
        "code": "132111"
    },
    {
        "english_name": "Electronic Engineering Operations Manager",
        "arabic_name": "مدير عمليات هندسة إلكترونية",
        "code": "132112"
    },
    {
        "english_name": "Chemical Engineering Operations Manager",
        "arabic_name": "مدير عمليات هندسة كيميائية",
        "code": "132113"
    },
    {
        "english_name": "Chief Operating Officer (COO)",
        "arabic_name": "مدير عمليات تشغيل",
        "code": "132114"
    },
    {
        "english_name": "Fabrication Laboratory Manager",
        "arabic_name": "مدير مختبر تصنيع",
        "code": "132115"
    },
    {
        "english_name": "Mining Manager",
        "arabic_name": "مدير تعدين",
        "code": "132201"
    },
    {
        "english_name": "Quarry Manager",
        "arabic_name": "مدير محجر",
        "code": "132202"
    },
    {
        "english_name": "Exploration of Oil & Gas Wells Manager",
        "arabic_name": "مدير استكشاف آبار النفط والغاز",
        "code": "132203"
    },
    {
        "english_name": "Rig Manager",
        "arabic_name": "مدير منصة حفر",
        "code": "132204"
    },
    {
        "english_name": "Quarries & Mines Production Manager",
        "arabic_name": "مدير انتاج مقالع ومناجم",
        "code": "132205"
    },
    {
        "english_name": "Oil & Gas Production Manager",
        "arabic_name": "مدير إنتاج النفط والغاز",
        "code": "132206"
    },
    {
        "english_name": "Oil & Gas Services Manager",
        "arabic_name": "مدير خدمات النفط والغاز",
        "code": "132207"
    },
    {
        "english_name": "Pipelines Manager",
        "arabic_name": "مدير خطوط أنابيب",
        "code": "132208"
    },
    {
        "english_name": "Geological Operations Manager",
        "arabic_name": "مدير عمليات جيولوجية",
        "code": "132209"
    },
    {
        "english_name": "Hydrological Operations Manager",
        "arabic_name": "مدير عمليات هيدرولوجية",
        "code": "132210"
    },
    {
        "english_name": "Oil Operations Control Manager",
        "arabic_name": "مدير مراقبة عمليات نفطية",
        "code": "132211"
    },
    {
        "english_name": "Civil Engineering Operations Manager",
        "arabic_name": "مدير عمليات هندسة مدنية",
        "code": "132301"
    },
    {
        "english_name": "Roads & Bridges Operations Manager",
        "arabic_name": "مدير عمليات طرق وجسور",
        "code": "132302"
    },
    {
        "english_name": "Construction Operations Manager",
        "arabic_name": "مدير عمليات إنشائية",
        "code": "132303"
    },
    {
        "english_name": "Urban Planning Manager",
        "arabic_name": "مدير التخطيط العمراني",
        "code": "132304"
    },
    {
        "english_name": "Port Manager",
        "arabic_name": "مدير ميناء",
        "code": "132401"
    },
    {
        "english_name": "Airport Manager",
        "arabic_name": "مدير مطار",
        "code": "132402"
    },
    {
        "english_name": "Railways Manager",
        "arabic_name": "مدير خطوط حديدية",
        "code": "132403"
    },
    {
        "english_name": "Land Transportation Station Manager",
        "arabic_name": "مدير محطة نقل بري",
        "code": "132404"
    },
    {
        "english_name": "Air Transportation Manager",
        "arabic_name": "مدير النقل الجوّي",
        "code": "132405"
    },
    {
        "english_name": "Land Transportation Manager",
        "arabic_name": "مدير النقل البرّي",
        "code": "132406"
    },
    {
        "english_name": "Marine Transportation Manager",
        "arabic_name": "مدير النقل البحري",
        "code": "132407"
    },
    {
        "english_name": "Rail Transport Manager",
        "arabic_name": "مدير النقل بالقطارات",
        "code": "132408"
    },
    {
        "english_name": "Aviation Operations Manager",
        "arabic_name": "مدير عمليات طيران",
        "code": "132409"
    },
    {
        "english_name": "Air Traffic Control Manager",
        "arabic_name": "مدير مراقبة جوية",
        "code": "132410"
    },
    {
        "english_name": "Railways Operations Manger",
        "arabic_name": "مدير عمليات تشغيل خطوط حديدية",
        "code": "132411"
    },
    {
        "english_name": "Land Transportation Station Operations Manger",
        "arabic_name": "مدير عمليات محطة نقل بري",
        "code": "132412"
    },
    {
        "english_name": "Ports Operations Manger",
        "arabic_name": "مدير عمليات موانئ",
        "code": "132413"
    },
    {
        "english_name": "Fleet Manager",
        "arabic_name": "مدير أسطول",
        "code": "132414"
    },
    {
        "english_name": "Logistics Services Manager",
        "arabic_name": "مدير خدمات لوجستية",
        "code": "132415"
    },
    {
        "english_name": "Supply Chain Manager",
        "arabic_name": "مدير سلسلة توريد",
        "code": "132416"
    },
    {
        "english_name": "Purchasing Manager",
        "arabic_name": "مدير مشتريات",
        "code": "132417"
    },
    {
        "english_name": "Warehouse Manager",
        "arabic_name": "مدير مستودع",
        "code": "132418"
    },
    {
        "english_name": "Post Office Manager",
        "arabic_name": "مدير مكتب بريد",
        "code": "132419"
    },
    {
        "english_name": "Postal Operations Manager",
        "arabic_name": "مدير عمليات بريدية",
        "code": "132420"
    },
    {
        "english_name": "IT Manager",
        "arabic_name": "مدير تقنية معلومات",
        "code": "133001"
    },
    {
        "english_name": "IT Engineering Manager",
        "arabic_name": "مدير هندسة تقنية معلومات",
        "code": "133002"
    },
    {
        "english_name": "Communications Manager",
        "arabic_name": "مدير اتصالات",
        "code": "133003"
    },
    {
        "english_name": "Communications Engineering Manager",
        "arabic_name": "مدير هندسة اتصالات",
        "code": "133004"
    },
    {
        "english_name": "Communications Networks’ Manager",
        "arabic_name": "مدير شبكات اتصالات",
        "code": "133005"
    },
    {
        "english_name": "Software Manager",
        "arabic_name": "مدير برمجيات",
        "code": "133006"
    },
    {
        "english_name": "IT Systems Manager",
        "arabic_name": "مدير أنظمة تقنية معلومات",
        "code": "133007"
    },
    {
        "english_name": "Data Security Manager",
        "arabic_name": "مدير أمن بيانات",
        "code": "133008"
    },
    {
        "english_name": "IT Technical Support Manager",
        "arabic_name": "مدير دعم فني تقنية معلومات",
        "code": "133009"
    },
    {
        "english_name": "Call Center Manager",
        "arabic_name": "مدير مركز اتصالات",
        "code": "133010"
    },
    {
        "english_name": "Database Manager",
        "arabic_name": "مدير قواعد بيانات",
        "code": "133011"
    },
    {
        "english_name": "Cybersecurity Manager",
        "arabic_name": "مدير أمن سيبراني",
        "code": "133012"
    },
    {
        "english_name": "Child Care Center Manager",
        "arabic_name": "مدير مركز رعاية الاطفال",
        "code": "134101"
    },
    {
        "english_name": "Kindergarten Manager",
        "arabic_name": "مدير روضة",
        "code": "134102"
    },
    {
        "english_name": "Health Affairs Manager",
        "arabic_name": "مدير شؤون صحية",
        "code": "134201"
    },
    {
        "english_name": "Health Facilities’ Control Manager",
        "arabic_name": "مدير رقابة مرافق صحية",
        "code": "134202"
    },
    {
        "english_name": "Public Health Manager",
        "arabic_name": "مدير صحة عامة",
        "code": "134203"
    },
    {
        "english_name": "Public Health Control Manager",
        "arabic_name": "مدير رقابة صحة عامة",
        "code": "134204"
    },
    {
        "english_name": "Hospital Manager",
        "arabic_name": "مدير مستشفى",
        "code": "134205"
    },
    {
        "english_name": "Health Center Manager",
        "arabic_name": "مدير مركز صحي",
        "code": "134206"
    },
    {
        "english_name": "Medical Analyses Laboratory Manager",
        "arabic_name": "مدير مختبر تحاليل طبية",
        "code": "134207"
    },
    {
        "english_name": "Chief Physician",
        "arabic_name": "رئيس الأطباء",
        "code": "134208"
    },
    {
        "english_name": "Chief Nurse",
        "arabic_name": "رئيس التمريض",
        "code": "134209"
    },
    {
        "english_name": "Veterinary Hospital Manager",
        "arabic_name": "مدير مستشفى بيطري",
        "code": "134210"
    },
    {
        "english_name": "Pharmacy Manager",
        "arabic_name": "مدير صيدلة",
        "code": "134211"
    },
    {
        "english_name": "Pharmaceutical Control Manager",
        "arabic_name": "مدير رقابة صيدلية",
        "code": "134212"
    },
    {
        "english_name": "Elderly Care Center Manager",
        "arabic_name": "مدير مركز رعاية مسنين",
        "code": "134301"
    },
    {
        "english_name": "Housing Affairs Manager",
        "arabic_name": "مدير شؤون إسكان",
        "code": "134401"
    },
    {
        "english_name": "Orphan Care Center Manager",
        "arabic_name": "مدير مركز رعاية الأيتام",
        "code": "134402"
    },
    {
        "english_name": "Juvenile Care Center Manager",
        "arabic_name": "مدير مركز رعاية احداث",
        "code": "134403"
    },
    {
        "english_name": "Handicapped Persons’ Care Center Manager",
        "arabic_name": "مدير مركز رعاية ذوي الاعاقة",
        "code": "134404"
    },
    {
        "english_name": "Social Care Center Manager",
        "arabic_name": "مدير مركز رعاية اجتماعية",
        "code": "134405"
    },
    {
        "english_name": "Social Affairs Manager",
        "arabic_name": "مدير شؤون إجتماعية",
        "code": "134406"
    },
    {
        "english_name": "Social Development Manager",
        "arabic_name": "مدير تنمية اجتماعية",
        "code": "134407"
    },
    {
        "english_name": "Manager of Social Insurance & Subsidies",
        "arabic_name": "مدير ضمان اجتماعي وإعانات",
        "code": "134408"
    },
    {
        "english_name": "Social Insurance Office Manager",
        "arabic_name": "مدير مكتب ضمان اجتماعي",
        "code": "134409"
    },
    {
        "english_name": "Rector",
        "arabic_name": "مدير جامعة",
        "code": "134501"
    },
    {
        "english_name": "Vice Rector",
        "arabic_name": "وكيل جامعة",
        "code": "134502"
    },
    {
        "english_name": "Dean",
        "arabic_name": "عميد كلية",
        "code": "134503"
    },
    {
        "english_name": "Institute Dean",
        "arabic_name": "مدير معهد",
        "code": "134504"
    },
    {
        "english_name": "Institute Vice Dean",
        "arabic_name": "وكيل معهد",
        "code": "134505"
    },
    {
        "english_name": "Headmaster",
        "arabic_name": "قائد مدرسة",
        "code": "134506"
    },
    {
        "english_name": "Assistant Headmaster",
        "arabic_name": "وكيل مدرسة",
        "code": "134507"
    },
    {
        "english_name": "Training Center Manager",
        "arabic_name": "مدير مركز تدريب",
        "code": "134508"
    },
    {
        "english_name": "Training Manager",
        "arabic_name": "مدير تدريب",
        "code": "134509"
    },
    {
        "english_name": "Training Programs Development Manager",
        "arabic_name": "مدير تطوير برامج تدريبية",
        "code": "134510"
    },
    {
        "english_name": "Educational Supervision Manager",
        "arabic_name": "مدير إشراف تعليمي",
        "code": "134511"
    },
    {
        "english_name": "Educational Supervision & Guidance Manager",
        "arabic_name": "مدير إشراف وتوجيه تربوي",
        "code": "134512"
    },
    {
        "english_name": "Technical Training Center Manager",
        "arabic_name": "مدير مركز تدريب فني",
        "code": "134513"
    },
    {
        "english_name": "Educational Curricula & Programs",
        "arabic_name": "مدير مناهج وبرامج تربوية",
        "code": "134514"
    },
    {
        "english_name": "Evaluation & Measurement Manager",
        "arabic_name": "مدير قياس وتقويم",
        "code": "134515"
    },
    {
        "english_name": "Admission & Registration Manager",
        "arabic_name": "مدير قبول وتسجيل",
        "code": "134516"
    },
    {
        "english_name": "Student Affairs Manager",
        "arabic_name": "مدير شؤون طلاب",
        "code": "134517"
    },
    {
        "english_name": "Dormitory Manager",
        "arabic_name": "مدير سكن طلاب",
        "code": "134518"
    },
    {
        "english_name": "Teacher Affairs Manager",
        "arabic_name": "مدير شؤون معلمين",
        "code": "134519"
    },
    {
        "english_name": "Bank Manager",
        "arabic_name": "مدير بنك",
        "code": "134601"
    },
    {
        "english_name": "Insurance Foundation Manager",
        "arabic_name": "مدير مؤسسة تأمين",
        "code": "134602"
    },
    {
        "english_name": "Financial Brokerage Manager",
        "arabic_name": "مدير مؤسسة وساطة مالية",
        "code": "134603"
    },
    {
        "english_name": "Finance Foundation Manager",
        "arabic_name": "مدير مؤسسة تمويل",
        "code": "134604"
    },
    {
        "english_name": "Lease Foundation Manager",
        "arabic_name": "مدير مؤسسة تأجير",
        "code": "134605"
    },
    {
        "english_name": "Head of Districts & Emirates Affairs’ Center",
        "arabic_name": "رئيس مركز شؤون مناطق وإمارات",
        "code": "134901"
    },
    {
        "english_name": "Municipal & Rural Affairs Manager",
        "arabic_name": "مدير شؤون بلدية وقروية",
        "code": "134902"
    },
    {
        "english_name": "Head of Municipality",
        "arabic_name": "رئيس بلدية",
        "code": "134903"
    },
    {
        "english_name": "Public Works & Facilities Manager",
        "arabic_name": "مدير أشغال ومرافق عامة",
        "code": "134904"
    },
    {
        "english_name": "Water & Sewage Processes’ Manager",
        "arabic_name": "مدير عمليات مياه وصرف صحي",
        "code": "134905"
    },
    {
        "english_name": "Weather Forecasting and Environmental Monitoring Station",
        "arabic_name": "مدير محطة تنبؤات جوية ورصد بيئي",
        "code": "134906"
    },
    {
        "english_name": "Meteorology Operations Manager",
        "arabic_name": "مدير عمليات أرصاد",
        "code": "134907"
    },
    {
        "english_name": "Environmental Protection Operations Manager",
        "arabic_name": "مدير عمليات حماية بيئة",
        "code": "134908"
    },
    {
        "english_name": "Safety Operations Manager",
        "arabic_name": "مدير عمليات سلامة",
        "code": "134909"
    },
    {
        "english_name": "Security Operations Manager",
        "arabic_name": "مدير عمليات أمن",
        "code": "134910"
    },
    {
        "english_name": "Legal Affairs Manager",
        "arabic_name": "مدير شؤون قانونية",
        "code": "134911"
    },
    {
        "english_name": "Head of Notary Public",
        "arabic_name": "رئيس كتابة عدل",
        "code": "134912"
    },
    {
        "english_name": "Grievances Manager",
        "arabic_name": "مدير التظلمات",
        "code": "134913"
    },
    {
        "english_name": "Forensic Investigation Affairs Manager",
        "arabic_name": "مدير شؤون تحقيق شرعي",
        "code": "134914"
    },
    {
        "english_name": "Religious Authority Manager",
        "arabic_name": "مدير هيئة دينية",
        "code": "134915"
    },
    {
        "english_name": "Advocacy and Outreach Office Manager",
        "arabic_name": "مدير مكتب دعوة وإرشاد",
        "code": "134916"
    },
    {
        "english_name": "Awqaf (Endowments) Manager",
        "arabic_name": "مدير أوقاف",
        "code": "134917"
    },
    {
        "english_name": "The Grand Mosque and the Prophet Mosque Operations Manger",
        "arabic_name": "مدير عمليات المسجد الحرام والمسجد النبوي",
        "code": "134918"
    },
    {
        "english_name": "Hajj and Umrah Operations Manager",
        "arabic_name": "مدير عمليات حج وعمرة",
        "code": "134919"
    },
    {
        "english_name": "Pilgrims Services Manager",
        "arabic_name": "مدير خدمات حجاج",
        "code": "134920"
    },
    {
        "english_name": "Religious Affairs Manager",
        "arabic_name": "مدير شؤون دينية",
        "code": "134921"
    },
    {
        "english_name": "Prosecution Affairs Manager",
        "arabic_name": "مدير شؤون ادعاء",
        "code": "134922"
    },
    {
        "english_name": "Attorney Affairs Manager",
        "arabic_name": "مدير شؤون محاماة",
        "code": "134923"
    },
    {
        "english_name": "Head of Investigation and Prosecution",
        "arabic_name": "رئيس دائرة تحقيق وادعاء",
        "code": "134924"
    },
    {
        "english_name": "Investigation and Prosecution Deputy",
        "arabic_name": "وكيل دائرة تحقيق وادعاء",
        "code": "134925"
    },
    {
        "english_name": "Cultural Affairs Manager",
        "arabic_name": "مدير شؤون ثقافية",
        "code": "134926"
    },
    {
        "english_name": "Library Manager",
        "arabic_name": "مدير مكتبة",
        "code": "134927"
    },
    {
        "english_name": "Museum Manager",
        "arabic_name": "مدير متحف",
        "code": "134928"
    },
    {
        "english_name": "Antiquities Manager",
        "arabic_name": "مدير آثار",
        "code": "134929"
    },
    {
        "english_name": "Art Gallery Manager",
        "arabic_name": "مدير معرض فني",
        "code": "134931"
    },
    {
        "english_name": "Archives & Documents Manager",
        "arabic_name": "مدير محفوظات ووثائق",
        "code": "134932"
    },
    {
        "english_name": "Translation Manager",
        "arabic_name": "مدير شؤون ترجمة",
        "code": "134933"
    },
    {
        "english_name": "Political Affairs Manager",
        "arabic_name": "مدير شؤون سياسية",
        "code": "134934"
    },
    {
        "english_name": "Crowd Management Manager",
        "arabic_name": "مدير إدارة حشود",
        "code": "134935"
    },
    {
        "english_name": "Customs operations manager",
        "arabic_name": "مدير عمليات جمركية",
        "code": "134937"
    },
    {
        "english_name": "Head of the fire brigade",
        "arabic_name": "رئيس وحدة الإطفاء",
        "code": "134938"
    },
    {
        "english_name": "Fire and Rescue Operations Manager",
        "arabic_name": "مدير عمليات إطفاء وإنقاذ",
        "code": "134939"
    },
    {
        "english_name": "Passport operations manager",
        "arabic_name": "مدير عمليات جوازات",
        "code": "134943"
    },
    {
        "english_name": "Nationality Operations manager",
        "arabic_name": "مدير عمليات إدارة الجنسية",
        "code": "134944"
    },
    {
        "english_name": "Residence Affairs Manager",
        "arabic_name": "مدير شؤون إقامة",
        "code": "134945"
    },
    {
        "english_name": "Civil Affairs Operations Manager",
        "arabic_name": "مدير عمليات أحوال مدينة",
        "code": "134946"
    },
    {
        "english_name": "Hotel Manager",
        "arabic_name": "مدير فندق",
        "code": "141101"
    },
    {
        "english_name": "Hotel operations manager",
        "arabic_name": "مدير عمليات فندقة",
        "code": "141102"
    },
    {
        "english_name": "Hotels control manager",
        "arabic_name": "مدير رقابة فنادق",
        "code": "141103"
    },
    {
        "english_name": "Hotel classification manager",
        "arabic_name": "مدير تصنيف فنادق",
        "code": "141104"
    },
    {
        "english_name": "Supply Manager",
        "arabic_name": "مدير تموين",
        "code": "141201"
    },
    {
        "english_name": "Hospitality Manager",
        "arabic_name": "مدير ضيافة",
        "code": "141202"
    },
    {
        "english_name": "Restaurant Manager",
        "arabic_name": "مدير مطعم",
        "code": "141203"
    },
    {
        "english_name": "Cafe Manager",
        "arabic_name": "مدير مقهى",
        "code": "141204"
    },
    {
        "english_name": "Food and Beverage Services Manager",
        "arabic_name": "مدير خدمات أطعمة ومشروبات",
        "code": "141205"
    },
    {
        "english_name": "Retail Sales Manager",
        "arabic_name": "مدير مبيعات تجزئة",
        "code": "142001"
    },
    {
        "english_name": "Store Manager",
        "arabic_name": "مدير متجر",
        "code": "142002"
    },
    {
        "english_name": "Wholesale Manager",
        "arabic_name": "مدير مبيعات جملة",
        "code": "142003"
    },
    {
        "english_name": "E-Commerce Manager",
        "arabic_name": "مدير تجارة إلكترونية",
        "code": "142004"
    },
    {
        "english_name": "Cultural Club Manager",
        "arabic_name": "مدير نادي ثقافي",
        "code": "143101"
    },
    {
        "english_name": "Country Club Manager",
        "arabic_name": "مدير نادي ريفي",
        "code": "143102"
    },
    {
        "english_name": "Entertainment Center Manager",
        "arabic_name": "مدير مركز ترفيهي",
        "code": "143103"
    },
    {
        "english_name": "Health Club Manager",
        "arabic_name": "مدير نادي صحي",
        "code": "143104"
    },
    {
        "english_name": "Sports Facility Manager",
        "arabic_name": "مدير منشأة رياضية",
        "code": "143105"
    },
    {
        "english_name": "Youth Hostel Manager",
        "arabic_name": "مدير بيت شباب",
        "code": "143106"
    },
    {
        "english_name": "Sports Affairs Manager",
        "arabic_name": "مدير شؤون رياضية",
        "code": "143107"
    },
    {
        "english_name": "Youth Welfare Operations manager",
        "arabic_name": "مدير عمليات رعاية شباب",
        "code": "143108"
    },
    {
        "english_name": "Film Production Manager",
        "arabic_name": "مدير إنتاج سينمائي",
        "code": "143109"
    },
    {
        "english_name": "Tourism Manager",
        "arabic_name": "مدير شؤون سياحية",
        "code": "143110"
    },
    {
        "english_name": "Media Manager",
        "arabic_name": "مدير إعلام",
        "code": "143111"
    },
    {
        "english_name": "Media Relations Manager",
        "arabic_name": "مدير شؤون إعلامية",
        "code": "143112"
    },
    {
        "english_name": "Media and Publishing Control Manager",
        "arabic_name": "مدير رقابة إعلام ونشر",
        "code": "143113"
    },
    {
        "english_name": "Printing and Publishing Manager",
        "arabic_name": "مدير طباعة ونشر",
        "code": "143114"
    },
    {
        "english_name": "Print Media Manager",
        "arabic_name": "مدير إعلام مطبوع",
        "code": "143115"
    },
    {
        "english_name": "Digital Media Manager",
        "arabic_name": "مدير إعلام رقمي",
        "code": "143116"
    },
    {
        "english_name": "Publication Art Direction Manager",
        "arabic_name": "مدير إخراج فني للمطبوعات",
        "code": "143117"
    },
    {
        "english_name": "Editing Manager",
        "arabic_name": "مدير تحرير",
        "code": "143118"
    },
    {
        "english_name": "News Agency Manager",
        "arabic_name": "مدير وكالة أنباء",
        "code": "143119"
    },
    {
        "english_name": "Theater manager",
        "arabic_name": "مدير مسرح",
        "code": "143120"
    },
    {
        "english_name": "Theatrical Production Manager",
        "arabic_name": "مدير إنتاج مسرحي",
        "code": "143121"
    },
    {
        "english_name": "TV Manager",
        "arabic_name": "مدير تلفزيون",
        "code": "143122"
    },
    {
        "english_name": "TV Production Manager",
        "arabic_name": "مدير إنتاج تلفزيوني",
        "code": "143123"
    },
    {
        "english_name": "Radio Manager",
        "arabic_name": "مدير إذاعة",
        "code": "143124"
    },
    {
        "english_name": "Radio Production Manager",
        "arabic_name": "مدير انتاج إذاعي",
        "code": "143125"
    },
    {
        "english_name": "Cinema Manager",
        "arabic_name": "مدير سينما",
        "code": "143126"
    },
    {
        "english_name": "Cinema Photography Manager",
        "arabic_name": "مدير تصوير سينمائي",
        "code": "143127"
    },
    {
        "english_name": "Shopping Center Manager",
        "arabic_name": "مدير مركز تسوق",
        "code": "143901"
    },
    {
        "english_name": "Travel Agency Manager",
        "arabic_name": "مدير وكالة سفر",
        "code": "143902"
    },
    {
        "english_name": "Camp Manager",
        "arabic_name": "مدير مخيم",
        "code": "143903"
    },
    {
        "english_name": "Physicist",
        "arabic_name": "فيزيائي",
        "code": "211101"
    },
    {
        "english_name": "Astronomer",
        "arabic_name": "أخصائي علوم فلك",
        "code": "211102"
    },
    {
        "english_name": "Astrophysical Sciences Specialist",
        "arabic_name": "أخصائي علوم فيزيائية فلكية",
        "code": "211103"
    },
    {
        "english_name": "Medical Physics Specialist",
        "arabic_name": "أخصائي فيزياء طبية",
        "code": "211104"
    },
    {
        "english_name": "Nuclear Physics Specialist",
        "arabic_name": "أخصائي علوم فيزياء نووية",
        "code": "211105"
    },
    {
        "english_name": "Meteorologist",
        "arabic_name": "أخصائي أرصاد جوية",
        "code": "211201"
    },
    {
        "english_name": "Climatologist",
        "arabic_name": "أخصائي علوم مناخ",
        "code": "211202"
    },
    {
        "english_name": "Chemist",
        "arabic_name": "كيميائي",
        "code": "211301"
    },
    {
        "english_name": "Industrial Chemist",
        "arabic_name": "كيميائي صناعات",
        "code": "211302"
    },
    {
        "english_name": "Pharmaceutical Sciences Specialist",
        "arabic_name": "أخصائي علوم صيدلانية",
        "code": "211303"
    },
    {
        "english_name": "Petrochemical Industries Chemist",
        "arabic_name": "كيميائي صناعات بتروكيميائية",
        "code": "211304"
    },
    {
        "english_name": "Geologist",
        "arabic_name": "جيولوجي",
        "code": "211401"
    },
    {
        "english_name": "Geophysicist",
        "arabic_name": "جيوفيزيائي",
        "code": "211402"
    },
    {
        "english_name": "Petroleum Geologist",
        "arabic_name": "جيولوجي نفط",
        "code": "211403"
    },
    {
        "english_name": "Hydrologist",
        "arabic_name": "هيدرولوجي",
        "code": "211404"
    },
    {
        "english_name": "Natural Resources Mining Geologist",
        "arabic_name": "جيولوجي تعدين مصادر طبيعية",
        "code": "211405"
    },
    {
        "english_name": "Seismic Monitoring Specialist",
        "arabic_name": "أخصائي رصد زلازل",
        "code": "211406"
    },
    {
        "english_name": "Oceanography Specialist",
        "arabic_name": "أخصائي علوم المحيطات",
        "code": "211407"
    },
    {
        "english_name": "Mathematics Science Specialist",
        "arabic_name": "أخصائي علوم رياضيات",
        "code": "212001"
    },
    {
        "english_name": "Actuary",
        "arabic_name": "إكتواري",
        "code": "212002"
    },
    {
        "english_name": "Statistician",
        "arabic_name": "إحصائي",
        "code": "212003"
    },
    {
        "english_name": "Data Analyst",
        "arabic_name": "محلل بيانات",
        "code": "212004"
    },
    {
        "english_name": "Health Statistician",
        "arabic_name": "إحصائي صحي",
        "code": "212005"
    },
    {
        "english_name": "Demographist",
        "arabic_name": "ديموجرافي",
        "code": "212006"
    },
    {
        "english_name": "Biological Sciences Specialist",
        "arabic_name": "أخصائي علوم أحياء",
        "code": "213101"
    },
    {
        "english_name": "Biochemist",
        "arabic_name": "أخصائي علوم كيمياء حيوية",
        "code": "213102"
    },
    {
        "english_name": "Biophysics Specialist",
        "arabic_name": "أخصائي علوم فيزياء حيوية",
        "code": "213103"
    },
    {
        "english_name": "Biotechnology Specialist",
        "arabic_name": "أخصائي تقنية حيوية",
        "code": "213104"
    },
    {
        "english_name": "Botanist",
        "arabic_name": "أخصائي علوم نبات",
        "code": "213105"
    },
    {
        "english_name": "Zoologist",
        "arabic_name": "أخصائي علوم حيوانات",
        "code": "213106"
    },
    {
        "english_name": "Marine Biologist",
        "arabic_name": "أخصائي علوم أحياء بحرية",
        "code": "213107"
    },
    {
        "english_name": "Entomologist",
        "arabic_name": "أخصائي علوم حشرات",
        "code": "213108"
    },
    {
        "english_name": "Pharmacologist",
        "arabic_name": "أخصائي علوم أدوية",
        "code": "213109"
    },
    {
        "english_name": "Genetic Specialist",
        "arabic_name": "أخصائي علوم وراثة",
        "code": "213110"
    },
    {
        "english_name": "Embryologist",
        "arabic_name": "أخصائي علوم أجنة",
        "code": "213111"
    },
    {
        "english_name": "Bacteriologist",
        "arabic_name": "أخصائي علوم بكتيريا",
        "code": "213112"
    },
    {
        "english_name": "Epidemiologist",
        "arabic_name": "أخصائي علوم أوبئة",
        "code": "213113"
    },
    {
        "english_name": "Microbiologist",
        "arabic_name": "أخصائي علوم أحياء دقيقة",
        "code": "213114"
    },
    {
        "english_name": "Medical Laboratory Scientist",
        "arabic_name": "أخصائي مختبرات طبية",
        "code": "213115"
    },
    {
        "english_name": "Clinical Laboratory Scientist",
        "arabic_name": "أخصائي مختبرات سريرية",
        "code": "213116"
    },
    {
        "english_name": "Agricultural Engineer",
        "arabic_name": "مهندس زراعي",
        "code": "213201"
    },
    {
        "english_name": "Agricultural Specialist",
        "arabic_name": "أخصائي زراعي",
        "code": "213202"
    },
    {
        "english_name": "Agricultural Extension Specialist",
        "arabic_name": "أخصائي إرشاد زراعي",
        "code": "213203"
    },
    {
        "english_name": "Forestry Specialist",
        "arabic_name": "أخصائي غابات",
        "code": "213204"
    },
    {
        "english_name": "Animal Husbandry Specialist",
        "arabic_name": "أخصائي تربية حيوانات",
        "code": "213205"
    },
    {
        "english_name": "Fish Farms and Crustaceans Specialist",
        "arabic_name": "أخصائي مزارع أسماك و قشريات",
        "code": "213206"
    },
    {
        "english_name": "Environmental Specialist",
        "arabic_name": "أخصائي بيئي",
        "code": "213301"
    },
    {
        "english_name": "Air Pollution Specialist",
        "arabic_name": "أخصائي تلوث هواء",
        "code": "213302"
    },
    {
        "english_name": "Water Quality Specialist",
        "arabic_name": "أخصائي جودة مياه",
        "code": "213303"
    },
    {
        "english_name": "Soil Rehabilitation Specialist",
        "arabic_name": "أخصائي إعادة تأهيل تربة",
        "code": "213304"
    },
    {
        "english_name": "Natural Reserves Specialist",
        "arabic_name": "أخصائي محميات طبيعية",
        "code": "213305"
    },
    {
        "english_name": "Industrial Engineer",
        "arabic_name": "مهندس صناعي",
        "code": "214101"
    },
    {
        "english_name": "Production Engineer",
        "arabic_name": "مهندس إنتاج",
        "code": "214102"
    },
    {
        "english_name": "Technical Production Engineer",
        "arabic_name": "مهندس إنتاج تقني",
        "code": "214103"
    },
    {
        "english_name": "Production Engineering Specialist",
        "arabic_name": "أخصائي تقنية هندسة إنتاج",
        "code": "214104"
    },
    {
        "english_name": "OSH Engineer",
        "arabic_name": "مهندس سلامة وصحة مهنية",
        "code": "214105"
    },
    {
        "english_name": "Civil Engineer",
        "arabic_name": "مهندس مدني",
        "code": "214201"
    },
    {
        "english_name": "Technical civil Engineer",
        "arabic_name": "مهندس مدني تقني",
        "code": "214202"
    },
    {
        "english_name": "Civil Engineering Tech Specialist",
        "arabic_name": "أخصائي تقنية هندسة  مدنية",
        "code": "214203"
    },
    {
        "english_name": "Geotechnical Engineer",
        "arabic_name": "مهندس جيوتقني",
        "code": "214204"
    },
    {
        "english_name": "Construction Engineer",
        "arabic_name": "مهندس إنشائي",
        "code": "214205"
    },
    {
        "english_name": "Road Engineer",
        "arabic_name": "مهندس طرق",
        "code": "214206"
    },
    {
        "english_name": "Bridge Engineer",
        "arabic_name": "مهندس جسور",
        "code": "214207"
    },
    {
        "english_name": "Environmental Engineer",
        "arabic_name": "مهندس بيئي",
        "code": "214301"
    },
    {
        "english_name": "Water Treatment Engineer",
        "arabic_name": "مهندس معالجة مياه",
        "code": "214302"
    },
    {
        "english_name": "Sanitary Engineer",
        "arabic_name": "مهندس صحي",
        "code": "214303"
    },
    {
        "english_name": "Mechanical Engineer",
        "arabic_name": "مهندس ميكانيكي",
        "code": "214401"
    },
    {
        "english_name": "Technical mechanical Engineer",
        "arabic_name": "مهندس ميكانيكي تقني",
        "code": "214402"
    },
    {
        "english_name": "Mechanical Engineering Specialist",
        "arabic_name": "أخصائي تقنية هندسة  ميكانيكية",
        "code": "214403"
    },
    {
        "english_name": "Aviation Engineer",
        "arabic_name": "مهندس طيران",
        "code": "214404"
    },
    {
        "english_name": "Naval Architect",
        "arabic_name": "مهندس بحري",
        "code": "214405"
    },
    {
        "english_name": "HVAC Engineer",
        "arabic_name": "مهندس تدفئة وتهوية وتكييف",
        "code": "214406"
    },
    {
        "english_name": "Welding Mechanical Engineer",
        "arabic_name": "مهندس ميكانيكي لحام",
        "code": "214407"
    },
    {
        "english_name": "Rail Mechanical Engineer",
        "arabic_name": "مهندس ميكانيكي قطارات",
        "code": "214408"
    },
    {
        "english_name": "Heavy Machinery Mechanical Engineer",
        "arabic_name": "مهندس ميكانيكي آليات ثقيلة",
        "code": "214409"
    },
    {
        "english_name": "Automotive Engineer",
        "arabic_name": "مهندس مركبات",
        "code": "214410"
    },
    {
        "english_name": "Turbine Engineer",
        "arabic_name": "مهندس توربينات",
        "code": "214411"
    },
    {
        "english_name": "Mechatronics Engineer",
        "arabic_name": "مهندس ميكاترونكس",
        "code": "214412"
    },
    {
        "english_name": "Chemical Engineer",
        "arabic_name": "مهندس كيميائي",
        "code": "214501"
    },
    {
        "english_name": "Technical Chemical Engineer",
        "arabic_name": "مهندس كيميائي تقني",
        "code": "214502"
    },
    {
        "english_name": "Chemical Engineering Specialist",
        "arabic_name": "أخصائي تقنية هندسة  كيميائية",
        "code": "214503"
    },
    {
        "english_name": "Water Desalination Engineer",
        "arabic_name": "مهندس تحلية مياه",
        "code": "214504"
    },
    {
        "english_name": "Mining Engineer",
        "arabic_name": "مهندس تعدين",
        "code": "214601"
    },
    {
        "english_name": "Metal Engineer",
        "arabic_name": "مهندس معادن",
        "code": "214602"
    },
    {
        "english_name": "Oil and Gas Engineer",
        "arabic_name": "مهندس نفط وغاز",
        "code": "214603"
    },
    {
        "english_name": "Biomedical Engineer",
        "arabic_name": "مهندس طب حيوي",
        "code": "214901"
    },
    {
        "english_name": "Cost Engineer",
        "arabic_name": "مهندس تكاليف",
        "code": "214902"
    },
    {
        "english_name": "Explosive Engineer",
        "arabic_name": "مهندس متفجرات",
        "code": "214903"
    },
    {
        "english_name": "Materials Engineer",
        "arabic_name": "مهندس مواد",
        "code": "214904"
    },
    {
        "english_name": "Quantity Surveyor",
        "arabic_name": "مساح كميات",
        "code": "214905"
    },
    {
        "english_name": "Quality Control Engineer",
        "arabic_name": "مهندس ضبط وتحكم في الجودة",
        "code": "214906"
    },
    {
        "english_name": "HSE Engineer",
        "arabic_name": "مهندس الصحة والسلامة والبيئة",
        "code": "214907"
    },
    {
        "english_name": "Research and Development Engineer",
        "arabic_name": "مهندس بحث وتطوير",
        "code": "214908"
    },
    {
        "english_name": "Project Management Engineer",
        "arabic_name": "مهندس إدارة مشاريع",
        "code": "214909"
    },
    {
        "english_name": "IT Engineer",
        "arabic_name": "مهندس تقنية معلومات",
        "code": "214910"
    },
    {
        "english_name": "IT System Engineer",
        "arabic_name": "مهندس نظم تقنية معلومات",
        "code": "214911"
    },
    {
        "english_name": "Network Engineer",
        "arabic_name": "مهندس شبكات",
        "code": "214912"
    },
    {
        "english_name": "Network Engineering Technology Specialist",
        "arabic_name": "أخصائي تقنية هندسة  شبكات",
        "code": "214913"
    },
    {
        "english_name": "Software Engineer",
        "arabic_name": "مهندس برمجيات",
        "code": "214914"
    },
    {
        "english_name": "Nuclear Engineer",
        "arabic_name": "مهندس نووي",
        "code": "214915"
    },
    {
        "english_name": "Electrical Engineer",
        "arabic_name": "مهندس كهربائي",
        "code": "215101"
    },
    {
        "english_name": "Tech. Electrical Engineer",
        "arabic_name": "مهندس كهربائي تقني",
        "code": "215102"
    },
    {
        "english_name": "Electrical Engineering Specialist",
        "arabic_name": "أخصائي تقنية هندسة  كهرباء",
        "code": "215103"
    },
    {
        "english_name": "Electromechanical Engineer",
        "arabic_name": "مهندس كهروميكانيكي",
        "code": "215104"
    },
    {
        "english_name": "Automation Engineer",
        "arabic_name": "مهندس أتمتة",
        "code": "215105"
    },
    {
        "english_name": "Power Generation Engineer",
        "arabic_name": "مهندس توليد طاقة",
        "code": "215106"
    },
    {
        "english_name": "Power Transmission and Distribution Engineer",
        "arabic_name": "مهندس نقل وتوزيع طاقة",
        "code": "215107"
    },
    {
        "english_name": "Wiring Electrical Engineer",
        "arabic_name": "مهندس كهربائي تمديدات",
        "code": "215108"
    },
    {
        "english_name": "Electronics Engineer",
        "arabic_name": "مهندس إلكترونيات",
        "code": "215201"
    },
    {
        "english_name": "Electronics Tech Engineer",
        "arabic_name": "مهندس إلكترونيات تقني",
        "code": "215202"
    },
    {
        "english_name": "Electronic Engineering Tech Specialist",
        "arabic_name": "أخصائي تقنية هندسة  إلكترونية",
        "code": "215203"
    },
    {
        "english_name": "Computer Engineer",
        "arabic_name": "مهندس حاسب آلي",
        "code": "215204"
    },
    {
        "english_name": "Computer Technical Engineer",
        "arabic_name": "مهندس حاسب آلي تقني",
        "code": "215205"
    },
    {
        "english_name": "IT Technology Engineering Specialist",
        "arabic_name": "أخصائي تقنية هندسة  تقنية معلومات",
        "code": "215206"
    },
    {
        "english_name": "Device Electronic Engineer",
        "arabic_name": "مهندس إلكتروني أجهزة",
        "code": "215207"
    },
    {
        "english_name": "Medical Devices Engineer",
        "arabic_name": "مهندس أجهزة طبية",
        "code": "215208"
    },
    {
        "english_name": "Medical Devices Technical Engineer",
        "arabic_name": "مهندس أجهزة طبية تقني",
        "code": "215209"
    },
    {
        "english_name": "Medical Devices Engineering Technology Specialist",
        "arabic_name": "أخصائي تقنية هندسة أجهزة طبية",
        "code": "215210"
    },
    {
        "english_name": "Communications Engineer",
        "arabic_name": "مهندس اتصالات",
        "code": "215301"
    },
    {
        "english_name": "Radio Engineer",
        "arabic_name": "مهندس راديو",
        "code": "215302"
    },
    {
        "english_name": "Broadcast Engineer",
        "arabic_name": "مهندس بث",
        "code": "215303"
    },
    {
        "english_name": "Radar Engineer",
        "arabic_name": "مهندس رادار",
        "code": "215304"
    },
    {
        "english_name": "Architect",
        "arabic_name": "مهندس معماري",
        "code": "216101"
    },
    {
        "english_name": "Interior Architect",
        "arabic_name": "مهندس معماري داخلي",
        "code": "216102"
    },
    {
        "english_name": "Landscape Engineer",
        "arabic_name": "مهندس تصميم مواقع",
        "code": "216201"
    },
    {
        "english_name": "Fashion Designer",
        "arabic_name": "مصمم أزياء",
        "code": "216301"
    },
    {
        "english_name": "Stylist",
        "arabic_name": "مصمم ملابس",
        "code": "216302"
    },
    {
        "english_name": "Industrial Designer",
        "arabic_name": "مصمم صناعي",
        "code": "216303"
    },
    {
        "english_name": "Furniture Designer",
        "arabic_name": "مصمم أثاث",
        "code": "216304"
    },
    {
        "english_name": "Jewelry Designer",
        "arabic_name": "مصمم مجوهرات",
        "code": "216305"
    },
    {
        "english_name": "Textile Designer",
        "arabic_name": "مصمم نسيج",
        "code": "216306"
    },
    {
        "english_name": "City Planner",
        "arabic_name": "مخطط مدن",
        "code": "216401"
    },
    {
        "english_name": "Traffic Planner",
        "arabic_name": "مخطط مرور",
        "code": "216402"
    },
    {
        "english_name": "Urban Planner",
        "arabic_name": "مخطط حضري",
        "code": "216403"
    },
    {
        "english_name": "Air Surveyor",
        "arabic_name": "مسّاح جوي",
        "code": "216501"
    },
    {
        "english_name": "Cartographer",
        "arabic_name": "رسام خرائط",
        "code": "216502"
    },
    {
        "english_name": "Geodetic Surveyor",
        "arabic_name": "مسّاح جيوديسي",
        "code": "216503"
    },
    {
        "english_name": "Hydrographic Surveyor",
        "arabic_name": "مسّاح هيدروغرافي",
        "code": "216504"
    },
    {
        "english_name": "Land Surveyor",
        "arabic_name": "مسّاح أراضي",
        "code": "216505"
    },
    {
        "english_name": "Mining Surveyor",
        "arabic_name": "مساح تعدين",
        "code": "216506"
    },
    {
        "english_name": "Photographic Surveyor",
        "arabic_name": "مساح تصويري",
        "code": "216507"
    },
    {
        "english_name": "Graphic Designer",
        "arabic_name": "مصمم جرافيك",
        "code": "216601"
    },
    {
        "english_name": "Animator",
        "arabic_name": "رسام رسوم متحركة",
        "code": "216602"
    },
    {
        "english_name": "Multimedia Designer",
        "arabic_name": "مصمم وسائط متعددة",
        "code": "216603"
    },
    {
        "english_name": "Advertising Designer",
        "arabic_name": "مصمم إعلان",
        "code": "216604"
    },
    {
        "english_name": "Digital Game Designer",
        "arabic_name": "مصمم ألعاب رقمية",
        "code": "216605"
    },
    {
        "english_name": "Security Documents and Markings Designer",
        "arabic_name": "مصمم وثائق وعلامات أمنية",
        "code": "216606"
    },
    {
        "english_name": "General Practitioner",
        "arabic_name": "طبيب عام",
        "code": "221101"
    },
    {
        "english_name": "Family Physician",
        "arabic_name": "طبيب أسرة",
        "code": "221102"
    },
    {
        "english_name": "Public Health Physician",
        "arabic_name": "طبيب صحة عامة",
        "code": "221103"
    },
    {
        "english_name": "Specialist Physician",
        "arabic_name": "طبيب أخصائي",
        "code": "221201"
    },
    {
        "english_name": "Internist",
        "arabic_name": "طبيب باطني",
        "code": "221202"
    },
    {
        "english_name": "Gastroenterologist",
        "arabic_name": "طبيب جهاز هضمي",
        "code": "221203"
    },
    {
        "english_name": "Pulmonologist",
        "arabic_name": "طبيب جهاز تنفسي",
        "code": "221204"
    },
    {
        "english_name": "Cardiovascular Physician",
        "arabic_name": "طبيب قلب وأوعية دموية",
        "code": "221205"
    },
    {
        "english_name": "Nephrologist",
        "arabic_name": "طبيب كلى",
        "code": "221206"
    },
    {
        "english_name": "Endocrinologist",
        "arabic_name": "طبيب أمراض غدد صماء",
        "code": "221207"
    },
    {
        "english_name": "Rheumatologist",
        "arabic_name": "طبيب أمراض رثوية",
        "code": "221208"
    },
    {
        "english_name": "Anesthetist",
        "arabic_name": "طبيب تخدير",
        "code": "221209"
    },
    {
        "english_name": "Intensivist",
        "arabic_name": "طبيب عناية مركزة",
        "code": "221210"
    },
    {
        "english_name": "Hematologist",
        "arabic_name": "طبيب أمراض الدم",
        "code": "221211"
    },
    {
        "english_name": "Allergist and Immunologist",
        "arabic_name": "طبيب أمراض حساسية ومناعة",
        "code": "221212"
    },
    {
        "english_name": "Dermatologist",
        "arabic_name": "طبيب أمراض جلدية",
        "code": "221213"
    },
    {
        "english_name": "Diagnostic Radiologist",
        "arabic_name": "طبيب أشعة تشخيصية",
        "code": "221214"
    },
    {
        "english_name": "Emergency Physician",
        "arabic_name": "طبيب طوارئ",
        "code": "221215"
    },
    {
        "english_name": "Laboratory Professional",
        "arabic_name": "طبيب مختبرات",
        "code": "221216"
    },
    {
        "english_name": "Genetic Diseases Specialist",
        "arabic_name": "طبيب أمراض وراثية",
        "code": "221217"
    },
    {
        "english_name": "General Surgeon",
        "arabic_name": "طبيب جراح",
        "code": "221218"
    },
    {
        "english_name": "Specialist Surgeon",
        "arabic_name": "جراح أخصائي",
        "code": "221219"
    },
    {
        "english_name": "Neurosurgeon",
        "arabic_name": "طبيب جراح مخ وأعصاب",
        "code": "221220"
    },
    {
        "english_name": "Neurologist",
        "arabic_name": "طبيب مخ وأعصاب",
        "code": "221221"
    },
    {
        "english_name": "Gynecologist",
        "arabic_name": "طبيب نساء وولادة",
        "code": "221222"
    },
    {
        "english_name": "Ophthalmologist",
        "arabic_name": "طبيب جراح عيون",
        "code": "221223"
    },
    {
        "english_name": "Orthopedic Surgeon",
        "arabic_name": "طبيب جراح عظام",
        "code": "221224"
    },
    {
        "english_name": "Otolaryngologist",
        "arabic_name": "طبيب جراح أنف وأذن وحنجرة ورأس وعنق",
        "code": "221225"
    },
    {
        "english_name": "Pediatrician",
        "arabic_name": "طبيب أطفال",
        "code": "221226"
    },
    {
        "english_name": "Pediatric Neurologist",
        "arabic_name": "طبيب أعصاب الأطفال",
        "code": "221227"
    },
    {
        "english_name": "Plastic Surgeon",
        "arabic_name": "طبيب جراح تجميل",
        "code": "221228"
    },
    {
        "english_name": "Radiotherapist",
        "arabic_name": "طبيب علاج إشعاعي",
        "code": "221229"
    },
    {
        "english_name": "Physiotherapist",
        "arabic_name": "طبيب علاج طبيعي",
        "code": "221230"
    },
    {
        "english_name": "Cardiothoracic Surgeon",
        "arabic_name": "طبيب جراح قلب وصدر",
        "code": "221231"
    },
    {
        "english_name": "Urological Surgeon",
        "arabic_name": "طبيب جراح مسالك بولية",
        "code": "221232"
    },
    {
        "english_name": "Psychologist",
        "arabic_name": "طبيب نفسي",
        "code": "221233"
    },
    {
        "english_name": "Nurse Specialist",
        "arabic_name": "أخصائي تمريض",
        "code": "222101"
    },
    {
        "english_name": "Specialized Nursing Specialist",
        "arabic_name": "أخصائي تمريض متخصص",
        "code": "222102"
    },
    {
        "english_name": "Community Health Nursing Specialist",
        "arabic_name": "أخصائي تمريض صحة مجتمع",
        "code": "222103"
    },
    {
        "english_name": "Maternal and Child Nursing Specialist",
        "arabic_name": "أخصائي تمريض أمومة وطفولة",
        "code": "222104"
    },
    {
        "english_name": "Anesthetic Nursing Specialist",
        "arabic_name": "أخصائي تمريض تخدير",
        "code": "222105"
    },
    {
        "english_name": "Clinical Nursing Specialist",
        "arabic_name": "أخصائي تمريض سريري",
        "code": "222106"
    },
    {
        "english_name": "Gynecology Nursing Specialist",
        "arabic_name": "أخصائي تمريض النساء والولادة",
        "code": "222107"
    },
    {
        "english_name": "Pediatric Nursing Specialist",
        "arabic_name": "أخصائي تمريض أطفال",
        "code": "222108"
    },
    {
        "english_name": "Pediatric Critical Care Nursing Specialist",
        "arabic_name": "أخصائي تمريض رعاية حرجة أطفال",
        "code": "222109"
    },
    {
        "english_name": "Neonatal Nursing Specialist",
        "arabic_name": "أخصائي تمريض حديثي الولادة",
        "code": "222110"
    },
    {
        "english_name": "Elderly Care Nursing Specialist",
        "arabic_name": "أخصائي تمريض رعاية كبار السن",
        "code": "222111"
    },
    {
        "english_name": "Surgical Nursing Specialist",
        "arabic_name": "أخصائي تمريض باطني وجراحي",
        "code": "222112"
    },
    {
        "english_name": "Critical Care Nursing Specialist",
        "arabic_name": "أخصائي تمريض الرعاية الحرجة",
        "code": "222113"
    },
    {
        "english_name": "Emergency Nursing Specialist",
        "arabic_name": "أخصائي تمريض طوارئ",
        "code": "222114"
    },
    {
        "english_name": "Primary Care Nursing Specialist",
        "arabic_name": "أخصائي تمريض رعاية أولية",
        "code": "222115"
    },
    {
        "english_name": "Psychological and Mental Health Nursing Specialist",
        "arabic_name": "أخصائي تمريض صحة نفسية وعقلية",
        "code": "222116"
    },
    {
        "english_name": "Midwifery Specialist",
        "arabic_name": "أخصائي قبالة",
        "code": "222201"
    },
    {
        "english_name": "Folk Medicine Specialist",
        "arabic_name": "أخصائي طب شعبي",
        "code": "223001"
    },
    {
        "english_name": "Acupuncture Specialist",
        "arabic_name": "أخصائي وخز بإبر صينية",
        "code": "223002"
    },
    {
        "english_name": "Naturopathy Specialist",
        "arabic_name": "أخصائي أدوية طبيعية",
        "code": "223003"
    },
    {
        "english_name": "Emergency Medical Care Specialist",
        "arabic_name": "أخصائي رعاية طبية طارئة",
        "code": "224001"
    },
    {
        "english_name": "Radiology Technician",
        "arabic_name": "أخصائي تقنية إشعاعية",
        "code": "224002"
    },
    {
        "english_name": "Veterinary",
        "arabic_name": "طبيب بيطري",
        "code": "225001"
    },
    {
        "english_name": "Veterinary Epidemiologist",
        "arabic_name": "أخصائي أوبئة بيطرية",
        "code": "225002"
    },
    {
        "english_name": "Dentist",
        "arabic_name": "طبيب أسنان عام",
        "code": "226101"
    },
    {
        "english_name": "Oral and Maxillofacial Doctor",
        "arabic_name": "طبيب فم ووجه وفكين",
        "code": "226102"
    },
    {
        "english_name": "Oral and Maxillofacial Surgeon",
        "arabic_name": "جراح فم ووجه وفكين",
        "code": "226103"
    },
    {
        "english_name": "Endodontist",
        "arabic_name": "طبيب معالجة لبية",
        "code": "226104"
    },
    {
        "english_name": "General Dentist",
        "arabic_name": "طبيب صحة عامة أسنان",
        "code": "226105"
    },
    {
        "english_name": "Pediatric Dentist",
        "arabic_name": "طبيب أسنان أطفال",
        "code": "226106"
    },
    {
        "english_name": "Family Dentist",
        "arabic_name": "طبيب أسنان الأسرة",
        "code": "226107"
    },
    {
        "english_name": "Oral and Maxillofacial Orthodontist",
        "arabic_name": "طبيب تقويم أسنان ووجه وفكين",
        "code": "226108"
    },
    {
        "english_name": "Dentist Anesthesiologist",
        "arabic_name": "طبيب تخدير أسنان",
        "code": "226109"
    },
    {
        "english_name": "Pharmacist",
        "arabic_name": "صيدلي",
        "code": "226201"
    },
    {
        "english_name": "Clinical Care Pharmacist",
        "arabic_name": "صيدلي رعاية صيدلانية",
        "code": "226202"
    },
    {
        "english_name": "Environmental Protection Specialist",
        "arabic_name": "أخصائي حماية بيئة",
        "code": "226301"
    },
    {
        "english_name": "Occupational Health and Safety Specialist",
        "arabic_name": "أخصائي صحة وسلامة مهنية",
        "code": "226302"
    },
    {
        "english_name": "Public Health Specialist",
        "arabic_name": "أخصائي صحة عامة",
        "code": "226303"
    },
    {
        "english_name": "Radiation Protection Specialist",
        "arabic_name": "اخصائي وقاية إشعاعية",
        "code": "226304"
    },
    {
        "english_name": "Physiotherapy Specialist",
        "arabic_name": "أخصائي علاج طبيعي",
        "code": "226401"
    },
    {
        "english_name": "Podiatrists",
        "arabic_name": "أخصائي علاج قدم",
        "code": "226402"
    },
    {
        "english_name": "Functional Therapist",
        "arabic_name": "أخصائي علاج وظيفي",
        "code": "226403"
    },
    {
        "english_name": "Respiratory Care Specialist",
        "arabic_name": "أخصائي رعاية تنفسية",
        "code": "226404"
    },
    {
        "english_name": "Artificial Limbs and Prosthetics Specialist",
        "arabic_name": "أخصائي أطراف صناعية وأجهزة تعويضية",
        "code": "226405"
    },
    {
        "english_name": "Nutritionist",
        "arabic_name": "أخصائي تغذية",
        "code": "226501"
    },
    {
        "english_name": "Clinical Nutritionist",
        "arabic_name": "أخصائي تغذية سريرية",
        "code": "226502"
    },
    {
        "english_name": "Sports Nutritionist",
        "arabic_name": "أخصائي تغذية رياضيين",
        "code": "226503"
    },
    {
        "english_name": "Dietitian",
        "arabic_name": "أخصائي حمية غذائية",
        "code": "226504"
    },
    {
        "english_name": "Audiologist",
        "arabic_name": "أخصائي سمعيات",
        "code": "226601"
    },
    {
        "english_name": "Speech Disorders Specialist",
        "arabic_name": "أخصائي اضطرابات تخاطب",
        "code": "226602"
    },
    {
        "english_name": "Audiology and Speech Pathologist",
        "arabic_name": "أخصائي أمراض نطق وسمع",
        "code": "226603"
    },
    {
        "english_name": "Optician",
        "arabic_name": "أخصائي بصريات",
        "code": "226701"
    },
    {
        "english_name": "Occupational Therapist",
        "arabic_name": "معالج مهني",
        "code": "226901"
    },
    {
        "english_name": "Medical Insurance Coverage Pre-authorization Specialist",
        "arabic_name": "أخصائي التفويض المسبق للتغطية بالتأمين الطبي",
        "code": "226902"
    },
    {
        "english_name": "Medical Quality Assurance Specialist",
        "arabic_name": "أخصائي ضمان الجودة الطبية",
        "code": "226903"
    },
    {
        "english_name": "Art Therapist",
        "arabic_name": "اخصائي علاج بالفنون",
        "code": "226904"
    },
    {
        "english_name": "Higher Education Professor",
        "arabic_name": "أستاذ تعليم عالي",
        "code": "231001"
    },
    {
        "english_name": "Educational Sciences Professor",
        "arabic_name": "أستاذ علوم تربوية",
        "code": "231002"
    },
    {
        "english_name": "Arts Professor",
        "arabic_name": "أستاذ فنون",
        "code": "231003"
    },
    {
        "english_name": "Business Administration Professor",
        "arabic_name": "أستاذ إدارة وأعمال",
        "code": "231004"
    },
    {
        "english_name": "Information and Telecommunications Technology Professor",
        "arabic_name": "أستاذ تقنية معلومات وإتصالات",
        "code": "231005"
    },
    {
        "english_name": "Engineering Sciences Professor",
        "arabic_name": "أستاذ علوم هندسية",
        "code": "231006"
    },
    {
        "english_name": "Architectural Engineering Professor",
        "arabic_name": "أستاذ علوم هندسة معمارية وبناء",
        "code": "231007"
    },
    {
        "english_name": "Health Science Professor",
        "arabic_name": "أستاذ علوم صحية",
        "code": "231008"
    },
    {
        "english_name": "Social and Humanitarian Sciences Professor",
        "arabic_name": "أستاذ علوم إنسانية",
        "code": "231009"
    },
    {
        "english_name": "Law Professor",
        "arabic_name": "أستاذ قانون",
        "code": "231010"
    },
    {
        "english_name": "Professor of Literature and Linguistics",
        "arabic_name": "أستاذ أدب ولغويات",
        "code": "231011"
    },
    {
        "english_name": "Social and Behavioral Sciences Professor",
        "arabic_name": "أستاذ علوم اجتماعية وسلوكية",
        "code": "231012"
    },
    {
        "english_name": "Media and Journalism Professor",
        "arabic_name": "أستاذ صحافة وإعلام",
        "code": "231013"
    },
    {
        "english_name": "Biological Sciences Professor",
        "arabic_name": "أستاذ علوم حيوية",
        "code": "231014"
    },
    {
        "english_name": "Physical Sciences Professor",
        "arabic_name": "أستاذ علوم فيزيائية",
        "code": "231015"
    },
    {
        "english_name": "Chemical Sciences Professor",
        "arabic_name": "أستاذ علوم كيميائية",
        "code": "231016"
    },
    {
        "english_name": "Mathematics and Statistics Professor",
        "arabic_name": "أستاذ رياضيات وإحصاء",
        "code": "231017"
    },
    {
        "english_name": "Environmental Sciences Professor",
        "arabic_name": "أستاذ علوم بيئة",
        "code": "231018"
    },
    {
        "english_name": "Agricultural Sciences Professor",
        "arabic_name": "أستاذ علوم زراعية",
        "code": "231019"
    },
    {
        "english_name": "Forest Sciences Professor",
        "arabic_name": "أستاذ علوم غابات",
        "code": "231020"
    },
    {
        "english_name": "Aquaculture Professor",
        "arabic_name": "أستاذ زراعة أحياء مائية",
        "code": "231021"
    },
    {
        "english_name": "Veterinary Sciences Professor",
        "arabic_name": "أستاذ علوم بيطرية",
        "code": "231022"
    },
    {
        "english_name": "Hotel and Tourism Professor",
        "arabic_name": "أستاذ فندقة وسياحة",
        "code": "231023"
    },
    {
        "english_name": "Security Sciences Professor",
        "arabic_name": "أستاذ علوم أمنية",
        "code": "231024"
    },
    {
        "english_name": "Logistics and Transportation Professor",
        "arabic_name": "أستاذ علوم لوجيستية ونقل",
        "code": "231025"
    },
    {
        "english_name": "Lecturer",
        "arabic_name": "محاضر",
        "code": "231026"
    },
    {
        "english_name": "Teaching Assistant",
        "arabic_name": "معيد",
        "code": "231027"
    },
    {
        "english_name": "Physical Education Professor",
        "arabic_name": "أستاذ تربية رياضية",
        "code": "231028"
    },
    {
        "english_name": "Professional Trainer",
        "arabic_name": "مدرب مهني",
        "code": "232001"
    },
    {
        "english_name": "Business and Management Trainer",
        "arabic_name": "مدرب أعمال وإدارة",
        "code": "232002"
    },
    {
        "english_name": "Engineering Trades Trainer",
        "arabic_name": "مدرب حرف هندسية",
        "code": "232003"
    },
    {
        "english_name": "ICT Trainer",
        "arabic_name": "مدرب تكنولوجيا اتصالات ومعلومات",
        "code": "232004"
    },
    {
        "english_name": "Applied Sciences Trainer",
        "arabic_name": "مدرب علوم تطبيقية",
        "code": "232005"
    },
    {
        "english_name": "Architecture Trades Trainer",
        "arabic_name": "مدرب حرف هندسة معمارية وبناء",
        "code": "232006"
    },
    {
        "english_name": "Arts Trainer",
        "arabic_name": "مدرب فنون",
        "code": "232007"
    },
    {
        "english_name": "Secondary Teacher",
        "arabic_name": "معلم ثانوي",
        "code": "233001"
    },
    {
        "english_name": "Secondary Teacher of Arabic Language",
        "arabic_name": "معلم ثانوي لغة عربية",
        "code": "233002"
    },
    {
        "english_name": "Secondary Teacher of Foreign Language",
        "arabic_name": "معلم ثانوي لغة أجنبية",
        "code": "233003"
    },
    {
        "english_name": "Secondary School Family Education Teachers",
        "arabic_name": "معلم ثانوي تربية أسرية",
        "code": "233004"
    },
    {
        "english_name": "Secondary School Social Studies Teacher",
        "arabic_name": "معلم ثانوي اجتماعيات",
        "code": "233005"
    },
    {
        "english_name": "Secondary Teacher of Economy",
        "arabic_name": "معلم ثانوي اقتصاد",
        "code": "233006"
    },
    {
        "english_name": "Secondary School Business Administration Teacher",
        "arabic_name": "معلم ثانوي إدارة أعمال",
        "code": "233007"
    },
    {
        "english_name": "Secondary School Accounting Teacher",
        "arabic_name": "معلم ثانوي محاسبة",
        "code": "233008"
    },
    {
        "english_name": "Secondary Teacher of Biology",
        "arabic_name": "معلم ثانوي أحياء",
        "code": "233009"
    },
    {
        "english_name": "Secondary Teacher of Physics",
        "arabic_name": "معلم ثانوي فيزياء",
        "code": "233010"
    },
    {
        "english_name": "Secondary Teacher of Chemistry",
        "arabic_name": "معلم ثانوي كيمياء",
        "code": "233011"
    },
    {
        "english_name": "Secondary Teacher of Mathematics",
        "arabic_name": "معلم ثانوي رياضيات",
        "code": "233012"
    },
    {
        "english_name": "Secondary Teacher of Physical Education",
        "arabic_name": "معلم ثانوي تربية صحية وبدنية",
        "code": "233013"
    },
    {
        "english_name": "Secondary Teacher of Computer",
        "arabic_name": "معلم ثانوي حاسب وبرمجة",
        "code": "233014"
    },
    {
        "english_name": "Secondary Teacher of Islamic Studies",
        "arabic_name": "معلم ثانوي دراسات إسلامية",
        "code": "233015"
    },
    {
        "english_name": "Secondary Teacher of Behavioral Studies",
        "arabic_name": "معلم ثانوي دراسات سلوكية",
        "code": "233016"
    },
    {
        "english_name": "Secondary School Geology Teacher",
        "arabic_name": "معلم ثانوي علوم أرض",
        "code": "233017"
    },
    {
        "english_name": "Secondary Arts Teacher",
        "arabic_name": "معلم ثانوي فنون",
        "code": "233018"
    },
    {
        "english_name": "Secondary School Librarianship Teacher",
        "arabic_name": "معلم ثانوي مكتبات",
        "code": "233019"
    },
    {
        "english_name": "Secondary School Vocational Education Teachers",
        "arabic_name": "معلم ثانوي تربية مهنية",
        "code": "233020"
    },
    {
        "english_name": "Secondary School Art Education Teacher",
        "arabic_name": "معلم ثانوي تربية فنية",
        "code": "233021"
    },
    {
        "english_name": "Secondary School Engineering Teacher",
        "arabic_name": "معلم ثانوي هندسة",
        "code": "233022"
    },
    {
        "english_name": "Secondary School Law Teacher",
        "arabic_name": "معلم ثانوي قانون",
        "code": "233023"
    },
    {
        "english_name": "Secondary School Health Sciences Teacher",
        "arabic_name": "معلم ثانوي علوم صحية",
        "code": "233024"
    },
    {
        "english_name": "Intermediate School Teacher",
        "arabic_name": "معلم مرحلة متوسطة",
        "code": "233025"
    },
    {
        "english_name": "Intermediate School Teacher of Arabic Language",
        "arabic_name": "معلم مرحلة متوسطة لغة عربية",
        "code": "233026"
    },
    {
        "english_name": "Intermediate School Teacher of Foreign Language",
        "arabic_name": "معلم مرحلة متوسطة لغة أجنبية",
        "code": "233027"
    },
    {
        "english_name": "Intermediate School Teacher of Home Economics",
        "arabic_name": "معلم مرحلة متوسطة تربية أسرية",
        "code": "233028"
    },
    {
        "english_name": "Intermediate School Teacher of Physical Education",
        "arabic_name": "معلم مرحلة متوسطة تربية صحية وبدنية",
        "code": "233029"
    },
    {
        "english_name": "Intermediate School Teacher of Computer",
        "arabic_name": "معلم مرحلة متوسطة حاسب آلي",
        "code": "233030"
    },
    {
        "english_name": "Intermediate School Teacher of Social and Behavioral Studies",
        "arabic_name": "معلم مرحلة متوسطة دراسات سلوكية",
        "code": "233031"
    },
    {
        "english_name": "Intermediate School Teacher of Islamic Studies",
        "arabic_name": "معلم مرحلة متوسطة تربية إسلامية",
        "code": "233032"
    },
    {
        "english_name": "Intermediate Level Math Teacher",
        "arabic_name": "معلم مرحلة متوسطة رياضيات",
        "code": "233033"
    },
    {
        "english_name": "Intermediate School Teacher of Sciences",
        "arabic_name": "معلم مرحلة متوسطة علوم",
        "code": "233034"
    },
    {
        "english_name": "Intermediate School Teacher of Arts",
        "arabic_name": "معلم مرحلة متوسطة فنون",
        "code": "233035"
    },
    {
        "english_name": "Intermediate Level Social Studies Teacher",
        "arabic_name": "معلم مرحلة متوسطة إجتماعيات",
        "code": "233036"
    },
    {
        "english_name": "Intermediate Level Art Education Teacher",
        "arabic_name": "معلم مرحلة متوسطة تربية فنية",
        "code": "233037"
    },
    {
        "english_name": "Primary School Teacher",
        "arabic_name": "معلم ابتدائي",
        "code": "234101"
    },
    {
        "english_name": "Primary Teacher of Arabic Language",
        "arabic_name": "معلم ابتدائي إجتماعيات ولغة عربية وإسلاميات",
        "code": "234102"
    },
    {
        "english_name": "Primary Teacher of Foreign Language",
        "arabic_name": "معلم ابتدائي لغة أجنبية",
        "code": "234103"
    },
    {
        "english_name": "Primary School Family Education Teachers",
        "arabic_name": "معلم ابتدائي تربية أسرية",
        "code": "234104"
    },
    {
        "english_name": "Primary School Health and Physical Education Teacher",
        "arabic_name": "معلم ابتدائي تربية صحية وبدنية",
        "code": "234105"
    },
    {
        "english_name": "Primary School Art Education Teachers",
        "arabic_name": "معلم ابتدائي تربية فنية",
        "code": "234106"
    },
    {
        "english_name": "Primary School Computer Science Teacher",
        "arabic_name": "معلم ابتدائي حاسب آلي",
        "code": "234107"
    },
    {
        "english_name": "Primary School Science and Mathematics Teacher",
        "arabic_name": "معلم ابتدائي علوم ورياضيات",
        "code": "234108"
    },
    {
        "english_name": "Elementary Grades Teacher",
        "arabic_name": "معلم صفوف أولية",
        "code": "234109"
    },
    {
        "english_name": "Pre-School Teacher",
        "arabic_name": "معلم تمهيدي",
        "code": "234201"
    },
    {
        "english_name": "Kindergarten Teacher",
        "arabic_name": "معلم رياض أطفال",
        "code": "234202"
    },
    {
        "english_name": "Nursery Teacher",
        "arabic_name": "معلم حضانة",
        "code": "234203"
    },
    {
        "english_name": "Teaching Methods Specialist",
        "arabic_name": "أخصائي أساليب تعليم",
        "code": "235101"
    },
    {
        "english_name": "Curriculum Development Specialist",
        "arabic_name": "أخصائي تطوير مناهج",
        "code": "235102"
    },
    {
        "english_name": "Educational Guidance Specialist",
        "arabic_name": "أخصائي توجيه تربوي",
        "code": "235103"
    },
    {
        "english_name": "Educational Supervision Specialist",
        "arabic_name": "أخصائي إشراف تربوي",
        "code": "235104"
    },
    {
        "english_name": "Measurement and Evaluation Specialist",
        "arabic_name": "أخصائي قياس وتقويم",
        "code": "235105"
    },
    {
        "english_name": "Training Programs Design Specialist",
        "arabic_name": "أخصائي تصميم برامج تدريبية",
        "code": "235106"
    },
    {
        "english_name": "Teaching Aids Specialist",
        "arabic_name": "أخصائي وسائل تعليمية",
        "code": "235107"
    },
    {
        "english_name": "Pedagogical Research Specialist",
        "arabic_name": "أخصائي بحث تربوي",
        "code": "235108"
    },
    {
        "english_name": "Braille Teacher",
        "arabic_name": "معلم برايل",
        "code": "235201"
    },
    {
        "english_name": "Sign Language Teacher",
        "arabic_name": "معلم لغة إشارة",
        "code": "235202"
    },
    {
        "english_name": "Teacher of Learning Difficulties",
        "arabic_name": "معلم صعوبات التعلم",
        "code": "235203"
    },
    {
        "english_name": "Teacher of Gifted Ones",
        "arabic_name": "معلم موهوبين",
        "code": "235204"
    },
    {
        "english_name": "Foreign Language Teacher",
        "arabic_name": "مدرس لغة أجنبية",
        "code": "235301"
    },
    {
        "english_name": "Vocal Performance Trainer",
        "arabic_name": "مدرب أداء صوتي",
        "code": "235401"
    },
    {
        "english_name": "Musical Instrument Teacher",
        "arabic_name": "معلم آلة موسيقية",
        "code": "235402"
    },
    {
        "english_name": "Shows Trainer",
        "arabic_name": "مدرب استعراضات",
        "code": "235501"
    },
    {
        "english_name": "Acting Trainer",
        "arabic_name": "مدرب تمثيل",
        "code": "235502"
    },
    {
        "english_name": "Plastic Arts Trainer",
        "arabic_name": "مدرب فنون تشكيلية",
        "code": "235503"
    },
    {
        "english_name": "IT Software and Applications Trainer",
        "arabic_name": "مدرب برامج وتطبيقات تقنية معلومات",
        "code": "235601"
    },
    {
        "english_name": "IT Trainer",
        "arabic_name": "مدرب تقنية معلومات",
        "code": "235602"
    },
    {
        "english_name": "Cybersecurity Curriculum Developer",
        "arabic_name": "مطور مناهج أمن سيبراني",
        "code": "235603"
    },
    {
        "english_name": "Cybersecurity Trainer",
        "arabic_name": "مدرب أمن سيبراني",
        "code": "235604"
    },
    {
        "english_name": "Guidance Counselor",
        "arabic_name": "مرشد طلابي",
        "code": "235901"
    },
    {
        "english_name": "Student Supervision Specialist",
        "arabic_name": "أخصائي إشراف طلابي",
        "code": "235902"
    },
    {
        "english_name": "Student Affairs Specialist",
        "arabic_name": "أخصائي شؤون طلاب",
        "code": "235903"
    },
    {
        "english_name": "Admission & Registration Specialist",
        "arabic_name": "أخصائي قبول وتسجيل",
        "code": "235904"
    },
    {
        "english_name": "Student Activities Specialist",
        "arabic_name": "أخصائي أنشطة طلابية",
        "code": "235905"
    },
    {
        "english_name": "Academic Researcher",
        "arabic_name": "باحث أكاديمي",
        "code": "235906"
    },
    {
        "english_name": "Accountant",
        "arabic_name": "محاسب",
        "code": "241101"
    },
    {
        "english_name": "Cost Accountant",
        "arabic_name": "محاسب تكاليف",
        "code": "241102"
    },
    {
        "english_name": "‎Staff Auditor",
        "arabic_name": "مراجع داخلي",
        "code": "241103"
    },
    {
        "english_name": "‎Treasurer",
        "arabic_name": "أمين صندوق",
        "code": "241104"
    },
    {
        "english_name": " External Auditor",
        "arabic_name": "مراجع خارجي",
        "code": "241105"
    },
    {
        "english_name": "‎Comptroller",
        "arabic_name": "مراقب مالي",
        "code": "241106"
    },
    {
        "english_name": "Budget Specialist",
        "arabic_name": "أخصائي موازنة مالية",
        "code": "241107"
    },
    {
        "english_name": "Tax Accounting Specialist",
        "arabic_name": "أخصائي حسابات ضرائب",
        "code": "241108"
    },
    {
        "english_name": "Inventory Control Specialist",
        "arabic_name": "أخصائي مراقبة مخزون",
        "code": "241109"
    },
    {
        "english_name": "Warehouse Specialist",
        "arabic_name": "أخصائي مستودعات",
        "code": "241110"
    },
    {
        "english_name": "Financial Consulting Specialist",
        "arabic_name": "أخصائي استشارات مالية",
        "code": "241201"
    },
    {
        "english_name": "Investment Specialist",
        "arabic_name": "أخصائي استثمار",
        "code": "241202"
    },
    {
        "english_name": "Financial Planning Specialist",
        "arabic_name": "أخصائي تخطيط مالي",
        "code": "241203"
    },
    {
        "english_name": "Corporate Finance Specialist",
        "arabic_name": "أخصائي تمويل شركات",
        "code": "241301"
    },
    {
        "english_name": "Credit Specialist",
        "arabic_name": "أخصائي ائتمان",
        "code": "241302"
    },
    {
        "english_name": "Financial Analysis Specialist",
        "arabic_name": "أخصائي تحليل مالي",
        "code": "241303"
    },
    {
        "english_name": "Financial Investigator",
        "arabic_name": "محقق مالي",
        "code": "241304"
    },
    {
        "english_name": "Financial Product Development Specialist",
        "arabic_name": "أخصائي تطوير منتجات مالية",
        "code": "241305"
    },
    {
        "english_name": "Insurance Specialist",
        "arabic_name": "أخصائي تأمين",
        "code": "241306"
    },
    {
        "english_name": "Banking Services Specialist",
        "arabic_name": "أخصائي خدمات مصرفية",
        "code": "241307"
    },
    {
        "english_name": "Treasury Specialist",
        "arabic_name": "أخصائي خزانة",
        "code": "241308"
    },
    {
        "english_name": "Business Continuity Specialist",
        "arabic_name": "أخصائي استمرارية الأعمال",
        "code": "241309"
    },
    {
        "english_name": "Securities Trading Specialist",
        "arabic_name": "أخصائي تداول أوراق مالية",
        "code": "241310"
    },
    {
        "english_name": "Financial Control Specialist",
        "arabic_name": "أخصائي رقابة مالية",
        "code": "241311"
    },
    {
        "english_name": "Government Revenue Specialist",
        "arabic_name": "أخصائي إيرادات حكومية",
        "code": "241312"
    },
    {
        "english_name": "Commitment Specialist",
        "arabic_name": "أخصائي التزام",
        "code": "242101"
    },
    {
        "english_name": "Risk-Management Specialist",
        "arabic_name": "أخصائي إدارة مخاطر",
        "code": "242102"
    },
    {
        "english_name": "Administrative Organization Specialist",
        "arabic_name": "أخصائي تنظيم إداري",
        "code": "242103"
    },
    {
        "english_name": "Change Management Specialist",
        "arabic_name": "أخصائي إدارة التغيير",
        "code": "242104"
    },
    {
        "english_name": "Administrative Development Specialist",
        "arabic_name": "أخصائي تطوير إداري",
        "code": "242105"
    },
    {
        "english_name": "Business Consulting Specialist",
        "arabic_name": "أخصائي استشارات أعمال",
        "code": "242106"
    },
    {
        "english_name": "Mail Operations Specialist",
        "arabic_name": "أخصائي عمليات بريدية",
        "code": "242107"
    },
    {
        "english_name": "Project Management Specialist",
        "arabic_name": "أخصائي إدارة مشاريع",
        "code": "242108"
    },
    {
        "english_name": "Service Management Specialist",
        "arabic_name": "أخصائي إدارة خدمات",
        "code": "242109"
    },
    {
        "english_name": "Emergency Management Specialist",
        "arabic_name": "أخصائي إدارة الطوارئ",
        "code": "242110"
    },
    {
        "english_name": "Nursing Management Specialist",
        "arabic_name": "أخصائي إدارة تمريض",
        "code": "242111"
    },
    {
        "english_name": "Pharmaceutical Management Specialist",
        "arabic_name": "أخصائي إدارة صيدلانية",
        "code": "242112"
    },
    {
        "english_name": "Aviation Affairs Specialist",
        "arabic_name": "أخصائي شؤون طيران",
        "code": "242113"
    },
    {
        "english_name": "Customs Specialist",
        "arabic_name": "أخصائي جمركي",
        "code": "242114"
    },
    {
        "english_name": "Value Engineering Specialist",
        "arabic_name": "أخصائي هندسة قيمية",
        "code": "242115"
    },
    {
        "english_name": "Security Specialist",
        "arabic_name": "أخصائي أمني",
        "code": "242116"
    },
    {
        "english_name": "Business Intelligence Specialist",
        "arabic_name": "أخصائي ذكاء أعمال",
        "code": "242117"
    },
    {
        "english_name": "Crisis Management Specialist",
        "arabic_name": "أخصائي إدارة أزمات",
        "code": "242118"
    },
    {
        "english_name": "Institutional Performance Specialist",
        "arabic_name": "أخصائي أداء مؤسسي",
        "code": "242119"
    },
    {
        "english_name": "Quality Specialist",
        "arabic_name": "أخصائي جودة",
        "code": "242120"
    },
    {
        "english_name": "Administrative Specialist",
        "arabic_name": "أخصائي إداري",
        "code": "242121"
    },
    {
        "english_name": "Quality Specifications and Metrics Specialist",
        "arabic_name": "اخصائي مواصفات ومقاييس وجودة",
        "code": "242122"
    },
    {
        "english_name": "Municipal Councils and Elections Specialist",
        "arabic_name": "أخصائي مجالس بلدية وانتخابات",
        "code": "242123"
    },
    {
        "english_name": "Region Affairs Specialist",
        "arabic_name": "أخصائي شؤون مناطق",
        "code": "242124"
    },
    {
        "english_name": "Vital Records Specialist",
        "arabic_name": "أخصائي أحوال مدنية",
        "code": "242125"
    },
    {
        "english_name": "Cybersecurity Consulting Specialist",
        "arabic_name": "أخصائي استشارات أمن سيبراني",
        "code": "242126"
    },
    {
        "english_name": "Cybersecurity Risk Specialist",
        "arabic_name": "أخصائي مخاطر أمن سيبراني",
        "code": "242127"
    },
    {
        "english_name": "Cybersecurity Compliance Officer",
        "arabic_name": "أخصائي التزام في الأمن سيبراني",
        "code": "242128"
    },
    {
        "english_name": "Cybersecurity Controls Assessor",
        "arabic_name": "مُقيّم ضوابط أمن سيبراني",
        "code": "242129"
    },
    {
        "english_name": "Cybersecurity Auditor",
        "arabic_name": "مدقق أمن سيبراني",
        "code": "242130"
    },
    {
        "english_name": "Process Control Specialist",
        "arabic_name": "أخصائي رقابة عمليات",
        "code": "242201"
    },
    {
        "english_name": "Labor Law Compliance Control Specialist",
        "arabic_name": "أخصائي رقابة أنظمة عمل",
        "code": "242202"
    },
    {
        "english_name": "Administrative Control Specialist",
        "arabic_name": "أخصائي رقابة إدارية",
        "code": "242203"
    },
    {
        "english_name": "Administrative Investigator",
        "arabic_name": "محقق إداري",
        "code": "242204"
    },
    {
        "english_name": "Strategy Specialist",
        "arabic_name": "أخصائي استراتيجيات",
        "code": "242205"
    },
    {
        "english_name": "Policy Specialist",
        "arabic_name": "أخصائي سياسات",
        "code": "242206"
    },
    {
        "english_name": "Cybersecurity Governance Officer",
        "arabic_name": "أخصائي حوكمة الأمن سيبراني",
        "code": "242207"
    },
    {
        "english_name": "Data Protection Officer",
        "arabic_name": "أخصائي حماية بيانات",
        "code": "242208"
    },
    {
        "english_name": "Job Engagement Specialist",
        "arabic_name": "أخصائي ارتباط وظيفي",
        "code": "242301"
    },
    {
        "english_name": "Human Resources Operation Specialist",
        "arabic_name": "أخصائي عمليات موارد بشرية",
        "code": "242302"
    },
    {
        "english_name": "Job and Occupational Classification Specialist",
        "arabic_name": "أخصائي تصنيف وظيفي ومهني",
        "code": "242303"
    },
    {
        "english_name": "Employment Specialist",
        "arabic_name": "أخصائي توظيف",
        "code": "242304"
    },
    {
        "english_name": "Compensations Specialist",
        "arabic_name": "أخصائي تعويضات",
        "code": "242305"
    },
    {
        "english_name": "Vocational Guidance Specialist",
        "arabic_name": "أخصائي توجيه مهني",
        "code": "242306"
    },
    {
        "english_name": "Labor Investigator",
        "arabic_name": "محقق عمالي",
        "code": "242307"
    },
    {
        "english_name": "Labor Organization Member",
        "arabic_name": "عضو هيئة عمالية",
        "code": "242308"
    },
    {
        "english_name": "Labor Force Planning Specialist",
        "arabic_name": "أخصائي تخطيط قوى عاملة",
        "code": "242309"
    },
    {
        "english_name": "Human Resources Control Specialist",
        "arabic_name": "أخصائي مراقبة موارد بشرية",
        "code": "242310"
    },
    {
        "english_name": "Recruitment Specialist",
        "arabic_name": "أخصائي استقدام",
        "code": "242311"
    },
    {
        "english_name": "Human Resources Training and Development Specialist",
        "arabic_name": "أخصائي تدريب وتطوير موارد بشرية",
        "code": "242401"
    },
    {
        "english_name": "Performance Management Specialist",
        "arabic_name": "أخصائي إدارة اداء",
        "code": "242402"
    },
    {
        "english_name": "Job Succession Specialist",
        "arabic_name": "أخصائي تعاقب وظيفي",
        "code": "242403"
    },
    {
        "english_name": "‎Career Path Specialist",
        "arabic_name": "أخصائي مسار وظيفي",
        "code": "242404"
    },
    {
        "english_name": "Advertising Specialist",
        "arabic_name": "أخصائي دعاية وإعلان",
        "code": "243101"
    },
    {
        "english_name": "Purchase Specialist",
        "arabic_name": "أخصائي مشتريات",
        "code": "243102"
    },
    {
        "english_name": "Contracts Specialist",
        "arabic_name": "أخصائي عقود",
        "code": "243103"
    },
    {
        "english_name": "Tender Specialist",
        "arabic_name": "أخصائي مناقصات",
        "code": "243104"
    },
    {
        "english_name": "Customer Services Specialist",
        "arabic_name": "أخصائي خدمة عملاء",
        "code": "243105"
    },
    {
        "english_name": "Commercial Specialist",
        "arabic_name": "أخصائي تجاري",
        "code": "243106"
    },
    {
        "english_name": "E-Commerce Specialist",
        "arabic_name": "أخصائي تجارة الكترونية",
        "code": "243107"
    },
    {
        "english_name": "Market Research Specialist",
        "arabic_name": "أخصائي أبحاث أسواق",
        "code": "243108"
    },
    {
        "english_name": "Sales Specialist",
        "arabic_name": "أخصائي مبيعات",
        "code": "243109"
    },
    {
        "english_name": "Marketing Specialist",
        "arabic_name": "أخصائي تسويق",
        "code": "243110"
    },
    {
        "english_name": "Investor Relation Specialist",
        "arabic_name": "أخصائي علاقات مستثمرين",
        "code": "243201"
    },
    {
        "english_name": "Public Relations Specialist",
        "arabic_name": "أخصائي علاقات عامة",
        "code": "243202"
    },
    {
        "english_name": "International Cooperation Specialist",
        "arabic_name": "أخصائي تعاون دولي",
        "code": "243203"
    },
    {
        "english_name": "Internal Communication Specialist",
        "arabic_name": "أخصائي تواصل داخلي",
        "code": "243204"
    },
    {
        "english_name": "Public Awareness Specialist",
        "arabic_name": "أخصائي توعية جمهور",
        "code": "243205"
    },
    {
        "english_name": "Conference and Event Organizing Specialist",
        "arabic_name": "أخصائي تنظيم مؤتمرات وفعاليات",
        "code": "243206"
    },
    {
        "english_name": "Protocol Specialist",
        "arabic_name": "أخصائي مراسم",
        "code": "243207"
    },
    {
        "english_name": "Medical Supplies Sales Specialist",
        "arabic_name": "أخصائي مبيعات مستلزمات طبية",
        "code": "243301"
    },
    {
        "english_name": "Pharmaceutical Product Sales Specialist",
        "arabic_name": "أخصائي مبيعات منتجات صيدلانية",
        "code": "243302"
    },
    {
        "english_name": "Industrial Product Sales Specialist",
        "arabic_name": "أخصائي مبيعات منتجات صناعية",
        "code": "243303"
    },
    {
        "english_name": "Information Technology and Telecommunication Devices Sales Specialist",
        "arabic_name": "أخصائي مبيعات أجهزة تقنية المعلومات والاتصالات",
        "code": "243401"
    },
    {
        "english_name": "Information Technology and Telecommunication Systems Sales Specialist",
        "arabic_name": "أخصائي مبيعات نظم تقنية المعلومات والاتصالات",
        "code": "243402"
    },
    {
        "english_name": "Computer Science Specialist",
        "arabic_name": "أخصائي علوم حاسب آلي",
        "code": "251101"
    },
    {
        "english_name": "Information Systems Analyst",
        "arabic_name": "محلل نظم المعلومات",
        "code": "251102"
    },
    {
        "english_name": "System Designer",
        "arabic_name": "مصمم نظم",
        "code": "251103"
    },
    {
        "english_name": "Systems Security Development Specialist",
        "arabic_name": "أخصائي تطوير أمن نظم",
        "code": "251104"
    },
    {
        "english_name": "Systems Security Analyst",
        "arabic_name": "محلل أمن النظم",
        "code": "251105"
    },
    {
        "english_name": "Cyber-security Specialist",
        "arabic_name": "أخصائي أمن سيبراني",
        "code": "251106"
    },
    {
        "english_name": "Vulnerability Assessment Specialist",
        "arabic_name": "اخصائي تقييم الثغرات",
        "code": "251107"
    },
    {
        "english_name": "Business Solutions Designer",
        "arabic_name": "مصمم حلول أعمال",
        "code": "251108"
    },
    {
        "english_name": "Cloud Computing Specialist",
        "arabic_name": "أخصائي حوسبة سحابية",
        "code": "251109"
    },
    {
        "english_name": "Secure Cloud Computing Specialist",
        "arabic_name": "أخصائي حوسبة سحابية آمنة",
        "code": "251110"
    },
    {
        "english_name": "Penetration Testing Specialist",
        "arabic_name": "أخصائي اختبار الاختراقات",
        "code": "251111"
    },
    {
        "english_name": "Software Developer",
        "arabic_name": "مطور برامج",
        "code": "251201"
    },
    {
        "english_name": "Software Engineer",
        "arabic_name": "مهندس برامج",
        "code": "251202"
    },
    {
        "english_name": "Software Designer",
        "arabic_name": "مصمم برامج",
        "code": "251203"
    },
    {
        "english_name": "Programmer Analyst",
        "arabic_name": "محلل مبرمج",
        "code": "251204"
    },
    {
        "english_name": "Application Developer",
        "arabic_name": "مطور تطبيقات",
        "code": "251205"
    },
    {
        "english_name": "Cybersecurity Developer",
        "arabic_name": "مطور أمن سيبراني",
        "code": "251206"
    },
    {
        "english_name": "Website Developer",
        "arabic_name": "مطور مواقع الكترونية",
        "code": "251301"
    },
    {
        "english_name": "Digital Gaming Developer",
        "arabic_name": "مطور العاب رقمية",
        "code": "251302"
    },
    {
        "english_name": "Applications Programmer",
        "arabic_name": "مبرمج تطبيقات",
        "code": "251401"
    },
    {
        "english_name": "Software Cybersecurity Assessor",
        "arabic_name": "مقيم أمن سيبراني للبرمجيات",
        "code": "251901"
    },
    {
        "english_name": "Systems Tester",
        "arabic_name": "مختبر نظم",
        "code": "251902"
    },
    {
        "english_name": "Software Tester",
        "arabic_name": "مختبر برامج",
        "code": "251903"
    },
    {
        "english_name": "Cybersecurity Researcher",
        "arabic_name": "باحث أمن سيبراني",
        "code": "251904"
    },
    {
        "english_name": "Malware Reverse Engineering Specialist",
        "arabic_name": "أخصائي الهندسة العكسية للبرمجيات الضارة",
        "code": "251905"
    },
    {
        "english_name": "Database Designer",
        "arabic_name": "مصمم قاعدة بيانات",
        "code": "252101"
    },
    {
        "english_name": "Database Management Specialist",
        "arabic_name": "أخصائي إدارة قواعد بيانات",
        "code": "252102"
    },
    {
        "english_name": "Database Analyst",
        "arabic_name": "محلل قاعدة بيانات",
        "code": "252103"
    },
    {
        "english_name": "Database Programmer",
        "arabic_name": "مبرمج قاعدة بيانات",
        "code": "252104"
    },
    {
        "english_name": "Data Security Specialist",
        "arabic_name": "أخصائي أمن بيانات",
        "code": "252105"
    },
    {
        "english_name": "System Administrator",
        "arabic_name": "مسؤول نظم",
        "code": "252201"
    },
    {
        "english_name": "Network Management Specialist",
        "arabic_name": "أخصائي إدارة شبكات",
        "code": "252202"
    },
    {
        "english_name": "Infrastructure Analyst",
        "arabic_name": "محلل بنية تحتية",
        "code": "252203"
    },
    {
        "english_name": "Cybersecurity Architect",
        "arabic_name": "مصمم معمارية أمن سيبراني",
        "code": "252204"
    },
    {
        "english_name": "Server Specialist",
        "arabic_name": "أخصائي خوادم",
        "code": "252205"
    },
    {
        "english_name": "Data Center Specialist",
        "arabic_name": "أخصائي مركز بيانات",
        "code": "252206"
    },
    {
        "english_name": "Cybersecurity Infrastructure Specialist",
        "arabic_name": "أخصائي بنية تحتية للأمن السيبراني",
        "code": "252207"
    },
    {
        "english_name": "Network Analyst",
        "arabic_name": "محلل شبكات",
        "code": "252301"
    },
    {
        "english_name": "Telecommunication Analyst",
        "arabic_name": "محلل اتصالات",
        "code": "252302"
    },
    {
        "english_name": "Digital Forensics Specialist",
        "arabic_name": "أخصائي التحليل الجنائي الرقمي",
        "code": "252901"
    },
    {
        "english_name": "Artificial intelligence Specialist",
        "arabic_name": "اخصائي ذكاء اصطناعي",
        "code": "252902"
    },
    {
        "english_name": "Cybersecurity Incident Responder",
        "arabic_name": "أخصائي استجابة للحوادث السيبرانية",
        "code": "252903"
    },
    {
        "english_name": "Cybersecurity Defense Analyst",
        "arabic_name": "محلل دفاع الأمن السيبراني",
        "code": "252904"
    },
    {
        "english_name": "Cybersecurity Artificial Intelligence Specialist",
        "arabic_name": "أخصائي ذكاء اصطناعي للأمن السيبراني",
        "code": "252905"
    },
    {
        "english_name": "Cybersecurity Data Science Specialist",
        "arabic_name": "أخصائي علم البيانات للأمن السيبراني",
        "code": "252906"
    },
    {
        "english_name": "Data Mining Specialist",
        "arabic_name": "أخصائي تنقيب بيانات",
        "code": "252907"
    },
    {
        "english_name": "Big Data Specialist",
        "arabic_name": "أخصائي بيانات ضخمة",
        "code": "252908"
    },
    {
        "english_name": "Data Science Specialist",
        "arabic_name": "أخصائي علوم بيانات",
        "code": "252909"
    },
    {
        "english_name": "Technical Contracts Management Specialist",
        "arabic_name": "أخصائي إدارة عقود تقنية",
        "code": "252910"
    },
    {
        "english_name": "Digital Transformation Specialist",
        "arabic_name": "أخصائي تحول رقمي",
        "code": "252911"
    },
    {
        "english_name": "Technical Support Specialist",
        "arabic_name": "اخصائي دعم فني",
        "code": "252912"
    },
    {
        "english_name": "Cryptography Specialist",
        "arabic_name": "أخصائي التشفير",
        "code": "252913"
    },
    {
        "english_name": "Identity and Permission Specialist",
        "arabic_name": "أخصائي إدارة هوية وصلاحيات",
        "code": "252914"
    },
    {
        "english_name": "Threat Intelligence Analyst",
        "arabic_name": "محلل معلومات التهديدات السيبرانية",
        "code": "252915"
    },
    {
        "english_name": "Threat Hunter",
        "arabic_name": "أخصائي اكتشاف التهديدات السيبرانية",
        "code": "252916"
    },
    {
        "english_name": "ICS/OT Cybersecurity Architect",
        "arabic_name": "مصمم معمارية أمن سيبراني لأنظمة تحكم صناعي",
        "code": "252918"
    },
    {
        "english_name": "ICS/OT Cybersecurity Defense Analyst",
        "arabic_name": "محلل دفاع أمن سيبراني لأنظمة تحكم صناعي",
        "code": "252919"
    },
    {
        "english_name": "ICS/OT Cybersecurity Risk Officer",
        "arabic_name": "أخصائي مخاطر أمن سيبراني لأنظمة تحكم صناعي",
        "code": "252920"
    },
    {
        "english_name": "ICS/OT Cybersecurity Incident Responder",
        "arabic_name": "أخصائي استجابة لحوادث سيبرانية لأنظمة تحكم صناعي",
        "code": "252921"
    },
    {
        "english_name": "Cyber Crime Investigator",
        "arabic_name": "أخصائي تحقيقات جرائم سيبرانية",
        "code": "252922"
    },
    {
        "english_name": "ICS/OT Cybersecurity Infrastructure Specialist",
        "arabic_name": "أخصائي بنية تحتية أمن سيبراني لأنظمة تحكم صناعي",
        "code": "252923"
    },
    {
        "english_name": "Lawyer",
        "arabic_name": "محامي",
        "code": "261101"
    },
    {
        "english_name": "Regular Investigator",
        "arabic_name": "محقق نظامي",
        "code": "261102"
    },
    {
        "english_name": "Prosecutor Representative",
        "arabic_name": "ممثل ادعاء",
        "code": "261103"
    },
    {
        "english_name": "Case Research Specialist",
        "arabic_name": "أخصائي بحث قضايا",
        "code": "261104"
    },
    {
        "english_name": "Arbitrator",
        "arabic_name": "محكّم",
        "code": "261105"
    },
    {
        "english_name": "Legal Specialist",
        "arabic_name": "أخصائي قانوني",
        "code": "261106"
    },
    {
        "english_name": "Cybersecurity Legal Specialist",
        "arabic_name": "أخصائي قانوني أمن سيبراني",
        "code": "261107"
    },
    {
        "english_name": "Judge",
        "arabic_name": "قاضي",
        "code": "261201"
    },
    {
        "english_name": "Forensic Physician",
        "arabic_name": "طبيب شرعي",
        "code": "261901"
    },
    {
        "english_name": "Notary Public",
        "arabic_name": "كاتب عدل",
        "code": "261902"
    },
    {
        "english_name": "Verbatim Reporter",
        "arabic_name": "كاتب ضبط",
        "code": "261903"
    },
    {
        "english_name": "Execution Officer",
        "arabic_name": "مأمور تنفيذ",
        "code": "261904"
    },
    {
        "english_name": "Archivist",
        "arabic_name": "أمين محفوظات",
        "code": "262101"
    },
    {
        "english_name": "Documents and Manuscripts Specialist",
        "arabic_name": "أخصائي وثائق ومخطوطات",
        "code": "262102"
    },
    {
        "english_name": "Curator",
        "arabic_name": "أمين متحف",
        "code": "262103"
    },
    {
        "english_name": "Museum Classifier",
        "arabic_name": "مصنّف متحف",
        "code": "262104"
    },
    {
        "english_name": "Museum Specialist",
        "arabic_name": "أخصائي متاحف",
        "code": "262105"
    },
    {
        "english_name": "Exhibition Curator",
        "arabic_name": "أمين معرض",
        "code": "262106"
    },
    {
        "english_name": "Health Informatics Specialist",
        "arabic_name": "أخصائي معلوماتية صحية",
        "code": "262107"
    },
    {
        "english_name": "librarian",
        "arabic_name": "أمين مكتبة",
        "code": "262201"
    },
    {
        "english_name": "Indexer",
        "arabic_name": "مفهرس",
        "code": "262202"
    },
    {
        "english_name": "Library Specialist",
        "arabic_name": "أخصائي مكتبات",
        "code": "262203"
    },
    {
        "english_name": "Economic Specialist",
        "arabic_name": "أخصائي اقتصاد",
        "code": "263101"
    },
    {
        "english_name": "Econometrics Specialist",
        "arabic_name": "أخصائي اقتصاد قياسي",
        "code": "263102"
    },
    {
        "english_name": "Antiquities Specialist",
        "arabic_name": "أخصائي آثار",
        "code": "263201"
    },
    {
        "english_name": "Geographer",
        "arabic_name": "أخصائي جغرافيا",
        "code": "263202"
    },
    {
        "english_name": "Antiquities Monitoring Specialist",
        "arabic_name": "أخصائي رقابة آثار",
        "code": "263203"
    },
    {
        "english_name": "Sociologist",
        "arabic_name": "أخصائي علم اجتماع",
        "code": "263204"
    },
    {
        "english_name": "Anthropologist",
        "arabic_name": "أخصائي علوم انسان",
        "code": "263205"
    },
    {
        "english_name": "Archaeological Excavation Specialist",
        "arabic_name": "أخصائي تنقيب اثار",
        "code": "263206"
    },
    {
        "english_name": "Tourism Development Specialist",
        "arabic_name": "أخصائي تطوير سياحي",
        "code": "263207"
    },
    {
        "english_name": "Tourism Guiding Specialist",
        "arabic_name": "أخصائي إرشاد سياحي",
        "code": "263208"
    },
    {
        "english_name": "Archaeological Guiding Specialist",
        "arabic_name": "أخصائي إرشاد آثار",
        "code": "263209"
    },
    {
        "english_name": "Hotel Specialist",
        "arabic_name": "أخصائي فندقة",
        "code": "263210"
    },
    {
        "english_name": "Tourism Specialist",
        "arabic_name": "أخصائي سياحة",
        "code": "263211"
    },
    {
        "english_name": "Hotel Monitoring Specialist",
        "arabic_name": "أخصائي رقابة فندقية",
        "code": "263212"
    },
    {
        "english_name": "Tourism Monitoring Specialist",
        "arabic_name": "أخصائي رقابة سياحية",
        "code": "263213"
    },
    {
        "english_name": "Cultural Activities Specialist",
        "arabic_name": "أخصائي أنشطة ثقافية",
        "code": "263214"
    },
    {
        "english_name": "Happiness Specialist",
        "arabic_name": "أخصائي سعادة",
        "code": "263215"
    },
    {
        "english_name": "Genealogist",
        "arabic_name": "أخصائي أنساب",
        "code": "263301"
    },
    {
        "english_name": "Historian",
        "arabic_name": "مؤرخ",
        "code": "263302"
    },
    {
        "english_name": "Political Science Specialist",
        "arabic_name": "أخصائي علوم سياسية",
        "code": "263303"
    },
    {
        "english_name": "Philosophy Specialist",
        "arabic_name": "أخصائي فلسفة",
        "code": "263304"
    },
    {
        "english_name": "History Specialist",
        "arabic_name": "أخصائي تاريخ",
        "code": "263305"
    },
    {
        "english_name": "Diplomatic attaché",
        "arabic_name": "ملحق دبلوماسي",
        "code": "263306"
    },
    {
        "english_name": "Psychology Specialist",
        "arabic_name": "أخصائي نفسي",
        "code": "263401"
    },
    {
        "english_name": "Psychological Counselling Specialist",
        "arabic_name": "أخصائي إرشاد نفسي",
        "code": "263402"
    },
    {
        "english_name": "Social Worker",
        "arabic_name": "أخصائي خدمة اجتماعية",
        "code": "263501"
    },
    {
        "english_name": "Family and Childhood Specialist",
        "arabic_name": "أخصائي أسرة وطفولة",
        "code": "263502"
    },
    {
        "english_name": "Social Security Specialist",
        "arabic_name": "أخصائي ضمان اجتماعي",
        "code": "263503"
    },
    {
        "english_name": "Juvenile Welfare Specialist",
        "arabic_name": "أخصائي رعاية أحداث",
        "code": "263504"
    },
    {
        "english_name": "Islamic Preacher",
        "arabic_name": "داعية",
        "code": "263601"
    },
    {
        "english_name": "Fatawa Research Specialist",
        "arabic_name": "أخصائي بحث فتاوى",
        "code": "263602"
    },
    {
        "english_name": "Leader of a Mosque",
        "arabic_name": "إمام مسجد",
        "code": "263603"
    },
    {
        "english_name": "Friday Prayer Elocutionist",
        "arabic_name": "خطيب جمعة",
        "code": "263604"
    },
    {
        "english_name": "Hajj and Umrah Specialist",
        "arabic_name": "أخصائي حج وعمرة",
        "code": "263605"
    },
    {
        "english_name": "Hajj and Umrah Services Observer",
        "arabic_name": "مراقب خدمات حج وعمرة",
        "code": "263606"
    },
    {
        "english_name": "Fatwa Commissioner",
        "arabic_name": "مفوض إفتاء",
        "code": "263607"
    },
    {
        "english_name": "Religious Research Specialist",
        "arabic_name": "أخصائي بحث ديني",
        "code": "263608"
    },
    {
        "english_name": "Religious Authority Member",
        "arabic_name": "عضو هيئة دينية",
        "code": "263609"
    },
    {
        "english_name": "Author",
        "arabic_name": "مؤلف",
        "code": "264101"
    },
    {
        "english_name": "Poet",
        "arabic_name": "شاعر",
        "code": "264102"
    },
    {
        "english_name": "Scriptwriter",
        "arabic_name": "كاتب سيناريو",
        "code": "264103"
    },
    {
        "english_name": "Technical Specifications Writer",
        "arabic_name": "كاتب مواصفات فنية",
        "code": "264104"
    },
    {
        "english_name": "Literary Editor",
        "arabic_name": "محرر أدبي",
        "code": "264105"
    },
    {
        "english_name": "Literary Critic",
        "arabic_name": "ناقد ادبي",
        "code": "264106"
    },
    {
        "english_name": "Journalist",
        "arabic_name": "صحفي",
        "code": "264201"
    },
    {
        "english_name": "Journalistic Writer",
        "arabic_name": "كاتب صحفي",
        "code": "264202"
    },
    {
        "english_name": "Journalistic Editor",
        "arabic_name": "محرر صحفي",
        "code": "264203"
    },
    {
        "english_name": "Media Specialist",
        "arabic_name": "أخصائي إعلامي",
        "code": "264204"
    },
    {
        "english_name": "Editor-in-chief",
        "arabic_name": "رئيس تحرير",
        "code": "264205"
    },
    {
        "english_name": "Media Critic",
        "arabic_name": "ناقد إعلامي",
        "code": "264206"
    },
    {
        "english_name": "Editorial Secretary",
        "arabic_name": "سكرتير تحرير",
        "code": "264207"
    },
    {
        "english_name": "Reporter",
        "arabic_name": "مراسل صحفي",
        "code": "264208"
    },
    {
        "english_name": "Media Censorship Specialist",
        "arabic_name": "أخصائي رقابة إعلامية",
        "code": "264209"
    },
    {
        "english_name": "Translator",
        "arabic_name": "مترجم",
        "code": "264301"
    },
    {
        "english_name": "Interpreter",
        "arabic_name": "مترجم فوري",
        "code": "264302"
    },
    {
        "english_name": "Proofreader",
        "arabic_name": "مصحح لغوي",
        "code": "264303"
    },
    {
        "english_name": "Sign Language Interpreter",
        "arabic_name": "مترجم لغة إشارة",
        "code": "264304"
    },
    {
        "english_name": "Linguist",
        "arabic_name": "أخصائي لغوي",
        "code": "264305"
    },
    {
        "english_name": "Cartoonist",
        "arabic_name": "رسام كاريكاتير",
        "code": "265101"
    },
    {
        "english_name": "Sculptor",
        "arabic_name": "نحّات",
        "code": "265102"
    },
    {
        "english_name": "Visual Artist",
        "arabic_name": "رسام تشكيلي",
        "code": "265103"
    },
    {
        "english_name": "Visual Arts Critic",
        "arabic_name": "ناقد فنون تشكيلية",
        "code": "265104"
    },
    {
        "english_name": "Documents and Manuscripts Restoration Specialist",
        "arabic_name": "أخصائي ترميم وثائق ومخطوطات",
        "code": "265105"
    },
    {
        "english_name": "Paintings Restoration Specialist",
        "arabic_name": "أخصائي ترميم ولوحات فنية",
        "code": "265106"
    },
    {
        "english_name": "Antiquities Restoration Specialist",
        "arabic_name": "أخصائي ترميم آثار",
        "code": "265107"
    },
    {
        "english_name": "Singer",
        "arabic_name": "مغني",
        "code": "265201"
    },
    {
        "english_name": "Composer",
        "arabic_name": "ملحن",
        "code": "265202"
    },
    {
        "english_name": "Musical Instruments Specialist",
        "arabic_name": "أخصائي آلات موسيقية",
        "code": "265203"
    },
    {
        "english_name": "Music Critic",
        "arabic_name": "ناقد موسيقي",
        "code": "265204"
    },
    {
        "english_name": "Musical Composer",
        "arabic_name": "مؤلف موسيقي",
        "code": "265205"
    },
    {
        "english_name": "Conductor",
        "arabic_name": "قائد فرقة موسيقية",
        "code": "265206"
    },
    {
        "english_name": "Band leader",
        "arabic_name": "قائد فرقة غنائية",
        "code": "265207"
    },
    {
        "english_name": "Show Dancer",
        "arabic_name": "راقص استعراضي",
        "code": "265301"
    },
    {
        "english_name": "Choreographer",
        "arabic_name": "مصمم رقصات",
        "code": "265302"
    },
    {
        "english_name": "Movies Director",
        "arabic_name": "مخرج أفلام",
        "code": "265401"
    },
    {
        "english_name": "Movies Producer",
        "arabic_name": "منتج أفلام",
        "code": "265402"
    },
    {
        "english_name": "Lighting Designer",
        "arabic_name": "مصمم إضاءة",
        "code": "265403"
    },
    {
        "english_name": "Theatrical Director",
        "arabic_name": "مخرج مسرحي",
        "code": "265404"
    },
    {
        "english_name": "Theatrical Producer",
        "arabic_name": "منتج مسرحي",
        "code": "265405"
    },
    {
        "english_name": "Television and Radio Director",
        "arabic_name": "مخرج تليفزيوني وإذاعي",
        "code": "265406"
    },
    {
        "english_name": "Television and Radio Producer",
        "arabic_name": "منتج تليفزيوني وإذاعي",
        "code": "265407"
    },
    {
        "english_name": "Art Critic",
        "arabic_name": "ناقد فني",
        "code": "265408"
    },
    {
        "english_name": "Photography Director",
        "arabic_name": "مخرج تصوير",
        "code": "265409"
    },
    {
        "english_name": "Sound Fitter",
        "arabic_name": "أخصائي تركيب صوتي",
        "code": "265410"
    },
    {
        "english_name": "Montage Specialist",
        "arabic_name": "أخصائي مونتاج",
        "code": "265411"
    },
    {
        "english_name": "Effects Specialist",
        "arabic_name": "أخصائي مؤثرات",
        "code": "265412"
    },
    {
        "english_name": "Thespian",
        "arabic_name": "ممثل مسرحي",
        "code": "265501"
    },
    {
        "english_name": "Movie and Television Actor",
        "arabic_name": "ممثل سينمائي وتلفزيوني",
        "code": "265502"
    },
    {
        "english_name": "Radio Actor",
        "arabic_name": "ممثل إذاعي",
        "code": "265503"
    },
    {
        "english_name": "Announcer",
        "arabic_name": "مذيع",
        "code": "265601"
    },
    {
        "english_name": "Sports Commentator",
        "arabic_name": "معلق رياضي",
        "code": "265602"
    },
    {
        "english_name": "Presenter",
        "arabic_name": "مقدم برامج",
        "code": "265603"
    },
    {
        "english_name": "Theater Wire Puller",
        "arabic_name": "محرك عرائس مسرحية",
        "code": "265901"
    },
    {
        "english_name": "Clown",
        "arabic_name": "مهرج أطفال",
        "code": "265902"
    },
    {
        "english_name": "Circus Acrobat",
        "arabic_name": "لاعب سيرك",
        "code": "265903"
    },
    {
        "english_name": "Pantomimist",
        "arabic_name": "فنان تعبير صامت",
        "code": "265904"
    },
    {
        "english_name": "Astronomy Technician",
        "arabic_name": "فني فلكي",
        "code": "311101"
    },
    {
        "english_name": "Meteorological Technician",
        "arabic_name": "فني رصد جوي",
        "code": "311102"
    },
    {
        "english_name": "Meteorological Supervisor",
        "arabic_name": "مشرف أرصاد جوية",
        "code": "311103"
    },
    {
        "english_name": "Chemical Technician",
        "arabic_name": "فني كيميائي",
        "code": "311104"
    },
    {
        "english_name": "Geological Technician",
        "arabic_name": "فني جيولوجي",
        "code": "311105"
    },
    {
        "english_name": "Physics Technician",
        "arabic_name": "فني فيزيائي",
        "code": "311106"
    },
    {
        "english_name": "Hydrologic Technician",
        "arabic_name": "فني هيدرولوجي",
        "code": "311107"
    },
    {
        "english_name": "Civil Engineering Technician",
        "arabic_name": "فني هندسة مدنية",
        "code": "311201"
    },
    {
        "english_name": "Fire Inspector",
        "arabic_name": "مفتش حرائق",
        "code": "311202"
    },
    {
        "english_name": "Construction Materials Technician",
        "arabic_name": "فني مواد إنشائية",
        "code": "311203"
    },
    {
        "english_name": "Construction Technician",
        "arabic_name": "فني إنشاءات",
        "code": "311204"
    },
    {
        "english_name": "Construction Maintenance Technician",
        "arabic_name": "فني صيانة انشاءات",
        "code": "311205"
    },
    {
        "english_name": "Building Insulation Technician",
        "arabic_name": "فني عزل مباني",
        "code": "311206"
    },
    {
        "english_name": "Building Maintenance Technician",
        "arabic_name": "فني صيانة مباني",
        "code": "311207"
    },
    {
        "english_name": "Excavation Shoring Technician",
        "arabic_name": "فني تدعيم حفريات",
        "code": "311208"
    },
    {
        "english_name": "Road Technician",
        "arabic_name": "فني طرق",
        "code": "311209"
    },
    {
        "english_name": "Road Maintenance Technician",
        "arabic_name": "فني صيانة طرق",
        "code": "311210"
    },
    {
        "english_name": "Survey Technician",
        "arabic_name": "فني مساحة",
        "code": "311211"
    },
    {
        "english_name": "Blasting Technician",
        "arabic_name": "فني تفجير",
        "code": "311212"
    },
    {
        "english_name": "Firefighting Technician",
        "arabic_name": "فني اطفاء",
        "code": "311213"
    },
    {
        "english_name": "Rescue Technician",
        "arabic_name": "فني إنقاذ",
        "code": "311214"
    },
    {
        "english_name": "Electrical Engineering Technician",
        "arabic_name": "فني هندسة كهربائية",
        "code": "311301"
    },
    {
        "english_name": "Overhead Electric Distribution Networks Technician",
        "arabic_name": "فني كهربائي شبكات توزيع هوائية",
        "code": "311302"
    },
    {
        "english_name": "Ground Electric Distribution Networks Technician",
        "arabic_name": "فني كهربائي شبكات توزيع أرضية",
        "code": "311303"
    },
    {
        "english_name": "Electrical Wiring Technician",
        "arabic_name": "فني كهربائي تمديدات كهربائية",
        "code": "311304"
    },
    {
        "english_name": "Electrical Machines Maintenance Technician",
        "arabic_name": "فني صيانة آلات كهربائية",
        "code": "311305"
    },
    {
        "english_name": "Electric Appliances Maintenance Technician",
        "arabic_name": "فني صيانة أجهزة كهربائية",
        "code": "311306"
    },
    {
        "english_name": "Electrical Networks Maintenance Technician",
        "arabic_name": "فني صيانة شبكات كهربائية",
        "code": "311307"
    },
    {
        "english_name": "Electromechanical Technician",
        "arabic_name": "فني كهروميكانيك",
        "code": "311308"
    },
    {
        "english_name": "Power Systems Protection Technician",
        "arabic_name": "فني كهربائي أنظمة حماية كهربائية",
        "code": "311309"
    },
    {
        "english_name": "Radio Broadcast Electronic Technician",
        "arabic_name": "فني إلكتروني أجهزة بث وإرسال إذاعي",
        "code": "311401"
    },
    {
        "english_name": "Television Broadcast Electronic Technician",
        "arabic_name": "فني إلكتروني أجهزة بث وإرسال تلفزيوني",
        "code": "311402"
    },
    {
        "english_name": "Electronic Devices Technician",
        "arabic_name": "فني أجهزة إلكترونية",
        "code": "311403"
    },
    {
        "english_name": "Electronic Devices Maintenance Technician",
        "arabic_name": "فني صيانة أجهزة إلكترونية",
        "code": "311404"
    },
    {
        "english_name": "Precision Instruments Technician",
        "arabic_name": "فني أجهزة دقيقة",
        "code": "311405"
    },
    {
        "english_name": "Digital Equipment Technician",
        "arabic_name": "فني أجهزة رقمية",
        "code": "311406"
    },
    {
        "english_name": "Autotronics Technician",
        "arabic_name": "فني أوتوترونيكس",
        "code": "311407"
    },
    {
        "english_name": "Medical Devices Technician",
        "arabic_name": "فني أجهزة طبية",
        "code": "311408"
    },
    {
        "english_name": "Electronic Engineering Technician",
        "arabic_name": "فني هندسة إلكترونية",
        "code": "311409"
    },
    {
        "english_name": "Mechanical Engineering Technician",
        "arabic_name": "فني هندسة ميكانيكية",
        "code": "311501"
    },
    {
        "english_name": "HVAC Technician",
        "arabic_name": "فني تدفئة وتهوية وتكييف",
        "code": "311502"
    },
    {
        "english_name": "Marine Surveyor",
        "arabic_name": "مسّاح بحري",
        "code": "311503"
    },
    {
        "english_name": "Marine Technician",
        "arabic_name": "فني بحري",
        "code": "311504"
    },
    {
        "english_name": "Mechanical Structural Technician",
        "arabic_name": "فني ميكانيكي هياكل",
        "code": "311505"
    },
    {
        "english_name": "Mechanical Motors Technician",
        "arabic_name": "فني ميكانيكي محركات",
        "code": "311506"
    },
    {
        "english_name": "Mechanical Vehicles Technician",
        "arabic_name": "فني ميكانيكي مركبات",
        "code": "311507"
    },
    {
        "english_name": "Heavy Equipment Mechanic",
        "arabic_name": "فني ميكانيكي معدات ثقيلة",
        "code": "311508"
    },
    {
        "english_name": "Agricultural Equipment Mechanic",
        "arabic_name": "فني ميكانيكي معدات زراعية",
        "code": "311509"
    },
    {
        "english_name": "Sanitary, Heating & Gas Installations Technician",
        "arabic_name": "فني ميكانيكي تمديدات صحية وتدفئة وغاز",
        "code": "311510"
    },
    {
        "english_name": "Mechanical Maintenance Technician",
        "arabic_name": "فني صيانة ميكانيكية",
        "code": "311511"
    },
    {
        "english_name": "Train Mechanical Technician",
        "arabic_name": "فني ميكانيكي قطارات",
        "code": "311512"
    },
    {
        "english_name": "Helicopters Mechanic",
        "arabic_name": "فني ميكانيكي طائرات مروحية",
        "code": "311513"
    },
    {
        "english_name": "Jet Aircraft Mechanic",
        "arabic_name": "فني ميكانيكي طائرات نفاثة",
        "code": "311514"
    },
    {
        "english_name": "Chemical Engineering Technician",
        "arabic_name": "فني هندسة كيميائية",
        "code": "311601"
    },
    {
        "english_name": "Chemical Plant Technician",
        "arabic_name": "فني مصانع كيميائية",
        "code": "311602"
    },
    {
        "english_name": "Metal Technician",
        "arabic_name": "فني معادن",
        "code": "311701"
    },
    {
        "english_name": "Mining Inspector",
        "arabic_name": "مفتش تعدين",
        "code": "311702"
    },
    {
        "english_name": "Mining Engineering Technician",
        "arabic_name": "فني هندسة تعدين",
        "code": "311703"
    },
    {
        "english_name": "Oil & Gas Wells Technician",
        "arabic_name": "فني آبار نفط وغاز",
        "code": "311704"
    },
    {
        "english_name": "Mines & Quarries Control Units Operator",
        "arabic_name": "مشغل وحدات تحكم مناجم ومحاجر",
        "code": "311705"
    },
    {
        "english_name": "Engineering Drafter",
        "arabic_name": "رسام هندسي",
        "code": "311801"
    },
    {
        "english_name": "Road Drafter",
        "arabic_name": "رسام مخططات طرق",
        "code": "311802"
    },
    {
        "english_name": "Technical Drafter",
        "arabic_name": "رسام فني مواصفات",
        "code": "311803"
    },
    {
        "english_name": "Architectural Models Technician",
        "arabic_name": "فني مجسمات معمارية",
        "code": "311804"
    },
    {
        "english_name": "Architectural Drafter",
        "arabic_name": "رسام معماري",
        "code": "311805"
    },
    {
        "english_name": "Forensic Science Technician",
        "arabic_name": "فني علوم جنائية",
        "code": "311901"
    },
    {
        "english_name": "Mechatronics Technician",
        "arabic_name": "فني ميكاترونيكس",
        "code": "311902"
    },
    {
        "english_name": "Quality Technician",
        "arabic_name": "فني جودة",
        "code": "311903"
    },
    {
        "english_name": "Quantity Calculation Technician",
        "arabic_name": "فني حساب كميات",
        "code": "311904"
    },
    {
        "english_name": "Production Efficiency Officer",
        "arabic_name": "فني كفاءة إنتاجية",
        "code": "311905"
    },
    {
        "english_name": "Production Engineering Technician",
        "arabic_name": "فني هندسة إنتاج",
        "code": "311906"
    },
    {
        "english_name": "Science Lab Technician",
        "arabic_name": "محضر مختبر علوم",
        "code": "311907"
    },
    {
        "english_name": "Mining Supervisor",
        "arabic_name": "مشرف تعدين",
        "code": "312101"
    },
    {
        "english_name": "Quarry Supervisor",
        "arabic_name": "مشرف محجر",
        "code": "312102"
    },
    {
        "english_name": "Manufacturing Supervisor",
        "arabic_name": "مشرف تصنيع",
        "code": "312201"
    },
    {
        "english_name": "Production Supervisor",
        "arabic_name": "مشرف إنتاج",
        "code": "312202"
    },
    {
        "english_name": "Maintenance Supervisor",
        "arabic_name": "مشرف صيانة",
        "code": "312203"
    },
    {
        "english_name": "Building Construction Supervisor",
        "arabic_name": "مشرف إنشاء مباني",
        "code": "312301"
    },
    {
        "english_name": "Road Construction Supervisor",
        "arabic_name": "مشرف إنشاء طرق",
        "code": "312302"
    },
    {
        "english_name": "Construction Site Supervisor",
        "arabic_name": "مشرف موقع إنشائي",
        "code": "312303"
    },
    {
        "english_name": "Construction Maintenance Supervisor",
        "arabic_name": "مشرف صيانة إنشاءات",
        "code": "312304"
    },
    {
        "english_name": "Construction Inspector",
        "arabic_name": "مفتش إنشاءات",
        "code": "312305"
    },
    {
        "english_name": "Power Plant Operator",
        "arabic_name": "مشغل محطة توليد طاقة",
        "code": "313101"
    },
    {
        "english_name": "Power Plant Control Panels Technician",
        "arabic_name": "فني لوحات تحكم محطة طاقة",
        "code": "313102"
    },
    {
        "english_name": "Electrical Power Distribution Technician",
        "arabic_name": "فني توزيع طاقة كهربائية",
        "code": "313103"
    },
    {
        "english_name": "Electric Power Transmission Technician",
        "arabic_name": "فني نقل طاقة كهربائية",
        "code": "313104"
    },
    {
        "english_name": "Desalination Plant Operator",
        "arabic_name": "مشغل محطة تحلية مياه",
        "code": "313201"
    },
    {
        "english_name": "Waste Incinerator Operator",
        "arabic_name": "مشغل محرقة مخلفات",
        "code": "313202"
    },
    {
        "english_name": "Wastewater Treatment Plant Operator",
        "arabic_name": "مشغل محطة معالجة مياه صرف صحي",
        "code": "313203"
    },
    {
        "english_name": "Water Encroachments & Leaks Inspector",
        "arabic_name": "مراقب تعديات وتسريبات مياه",
        "code": "313204"
    },
    {
        "english_name": "Water Processes Controller",
        "arabic_name": "مراقب عمليات مياه",
        "code": "313205"
    },
    {
        "english_name": "Industrial Wastewater Treatment Unit Inspector",
        "arabic_name": "مراقب وحدة معالجة مياه صرف صناعي",
        "code": "313206"
    },
    {
        "english_name": "Wastewater Pipes Treatment Technician",
        "arabic_name": "فني تنقية مجاري صرف صحي",
        "code": "313207"
    },
    {
        "english_name": "Water & Wastewater Plant’s Control Panels Technician",
        "arabic_name": "فني لوحات تحكم محطة مياه وصرف صحي",
        "code": "313208"
    },
    {
        "english_name": "Chemical Processes Technician",
        "arabic_name": "فني عمليات كيميائية",
        "code": "313301"
    },
    {
        "english_name": "Chemical Reactor Operation Technician",
        "arabic_name": "فني تشغيل مفاعل كيميائي",
        "code": "313302"
    },
    {
        "english_name": "Chemical Process Control Panels Technician",
        "arabic_name": "فني لوحات تحكم عمليات كيميائية",
        "code": "313303"
    },
    {
        "english_name": "Gas Plant Operation Technician",
        "arabic_name": "فني تشغيل محطة غاز",
        "code": "313401"
    },
    {
        "english_name": "Oil Refining Technician",
        "arabic_name": "فني تكرير نفط",
        "code": "313402"
    },
    {
        "english_name": "Oil Derivatives Production Technician",
        "arabic_name": "فني انتاج مشتقات نفطية",
        "code": "313403"
    },
    {
        "english_name": "Oil Refining Operations Control Panel Technician",
        "arabic_name": "فني لوحة تحكم عمليات تكرير نفط",
        "code": "313404"
    },
    {
        "english_name": "Metal Production Process Supervisor",
        "arabic_name": "مراقب عملية إنتاج المعادن",
        "code": "313501"
    },
    {
        "english_name": "Metal Melting Furnace Technician",
        "arabic_name": "فني فرن صهر معادن",
        "code": "313502"
    },
    {
        "english_name": "Metal Rolling Control Panel Operation Technician",
        "arabic_name": "فني تشغيل لوحة تحكم درفلة المعادن",
        "code": "313503"
    },
    {
        "english_name": "Metal Casting Unit Technician",
        "arabic_name": "فني تشغيل وحدة سبك معادن",
        "code": "313504"
    },
    {
        "english_name": "Automated Assembly Line Technician",
        "arabic_name": "مراقب حركة مركبات",
        "code": "313901"
    },
    {
        "english_name": "Stationmaster",
        "arabic_name": "فني تشغيل خط تجميع آلي",
        "code": "313902"
    },
    {
        "english_name": "Train Observer",
        "arabic_name": "ناظر محطة سكك حديدية",
        "code": "313903"
    },
    {
        "english_name": "Vehicle Movement Controller",
        "arabic_name": "مراقب حركة قطارات",
        "code": "313904"
    },
    {
        "english_name": "Products’ Quality Control Technician",
        "arabic_name": "فني ضبط جودة منتجات",
        "code": "313905"
    },
    {
        "english_name": "Standards & Specifications Inspector",
        "arabic_name": "مفتش مقاييس ومواصفات",
        "code": "313906"
    },
    {
        "english_name": "Warehouse Technician",
        "arabic_name": "أمين مستودع فني",
        "code": "313907"
    },
    {
        "english_name": "Biological Technician",
        "arabic_name": "فني أحياء",
        "code": "314101"
    },
    {
        "english_name": "Pharmaceutical Science Technician",
        "arabic_name": "فني علوم صيدلانية",
        "code": "314102"
    },
    {
        "english_name": "Botanical Technician",
        "arabic_name": "فني علوم نباتات",
        "code": "314103"
    },
    {
        "english_name": "Insect Science Technician",
        "arabic_name": "فني علوم حشرات",
        "code": "314104"
    },
    {
        "english_name": "Animal Science Technician",
        "arabic_name": "فني علوم حيوانية",
        "code": "314105"
    },
    {
        "english_name": "Food Science Technician",
        "arabic_name": "فني علوم أغذية",
        "code": "314106"
    },
    {
        "english_name": "Agricultural Technician",
        "arabic_name": "فني زراعي",
        "code": "314201"
    },
    {
        "english_name": "Aquaculture Technician",
        "arabic_name": "فني زراعي أحياء مائية",
        "code": "314202"
    },
    {
        "english_name": "Irrigation Technician",
        "arabic_name": "فني ري",
        "code": "314203"
    },
    {
        "english_name": "Cattle Breeding Technician",
        "arabic_name": "فني تربية ماشية",
        "code": "314204"
    },
    {
        "english_name": "Poultry Breeding Technician",
        "arabic_name": "فني تربية دواجن",
        "code": "314205"
    },
    {
        "english_name": "Pest Control Technician",
        "arabic_name": "فني مكافحة آفات",
        "code": "314206"
    },
    {
        "english_name": "Beneficial Insects Raising Technician",
        "arabic_name": "فني زراعي تربية حشرات نافعة",
        "code": "314207"
    },
    {
        "english_name": "Agricultural Extension Technician",
        "arabic_name": "فني إرشاد زراعي",
        "code": "314208"
    },
    {
        "english_name": "Forestry Technician",
        "arabic_name": "فني غابات",
        "code": "314301"
    },
    {
        "english_name": "Pasture Technician",
        "arabic_name": "فني مراعي",
        "code": "314302"
    },
    {
        "english_name": "Reserved Planting Technician",
        "arabic_name": "فني زراعة محمية",
        "code": "314303"
    },
    {
        "english_name": "Ship Engineering Technician",
        "arabic_name": "فني هندسة سفن",
        "code": "315101"
    },
    {
        "english_name": "Ship Safety Technician",
        "arabic_name": "فني سلامة سفن",
        "code": "315102"
    },
    {
        "english_name": "Vessel Traffic Guide",
        "arabic_name": "مرشد حركة السفن",
        "code": "315201"
    },
    {
        "english_name": "Marine Navigator",
        "arabic_name": "ملاح بحري",
        "code": "315202"
    },
    {
        "english_name": "Ship Captain",
        "arabic_name": "ربان سفينة",
        "code": "315203"
    },
    {
        "english_name": "Tugboat Captain",
        "arabic_name": "ربان قاطرة مراكب",
        "code": "315204"
    },
    {
        "english_name": "Carrier Captain",
        "arabic_name": "ربان ناقلة",
        "code": "315205"
    },
    {
        "english_name": "Ferry Captain",
        "arabic_name": "ربان عبارة",
        "code": "315206"
    },
    {
        "english_name": "Port Monitor",
        "arabic_name": "مراقب موانئ",
        "code": "315207"
    },
    {
        "english_name": "Marine Observer",
        "arabic_name": "مراقب بحري",
        "code": "315208"
    },
    {
        "english_name": "Airman",
        "arabic_name": "ملاح جوي",
        "code": "315301"
    },
    {
        "english_name": "Flight Instructor",
        "arabic_name": "مدرب طيران",
        "code": "315302"
    },
    {
        "english_name": "Helicopter Pilot",
        "arabic_name": "طيار هليكوبتر",
        "code": "315303"
    },
    {
        "english_name": "Fixed-Wing Aircraft Pilot",
        "arabic_name": "طيار جناح ثابت",
        "code": "315304"
    },
    {
        "english_name": "Co-Pilot",
        "arabic_name": "مساعد طيار",
        "code": "315305"
    },
    {
        "english_name": "Aviation Operations Inspector",
        "arabic_name": "مفتش عمليات طيران",
        "code": "315306"
    },
    {
        "english_name": "Air Observer",
        "arabic_name": "مراقب جوي",
        "code": "315401"
    },
    {
        "english_name": "Ground Movement Coordinator",
        "arabic_name": "منسق حركة أرضية",
        "code": "315402"
    },
    {
        "english_name": "Aviation Safety Technician",
        "arabic_name": "فني سلامة طيران",
        "code": "315501"
    },
    {
        "english_name": "Airworthiness Inspector",
        "arabic_name": "مفتش صلاحية طيران",
        "code": "315502"
    },
    {
        "english_name": "Therapeutic Radiologic Technologist",
        "arabic_name": "فني أشعة علاجية",
        "code": "321101"
    },
    {
        "english_name": "Radiographer",
        "arabic_name": "فني أشعة",
        "code": "321102"
    },
    {
        "english_name": "Cardiac Imaging Technician",
        "arabic_name": "فني تصوير قلب",
        "code": "321103"
    },
    {
        "english_name": "ECG Technician",
        "arabic_name": "فني تخطيط قلب",
        "code": "321104"
    },
    {
        "english_name": "NCV Technician",
        "arabic_name": "فني تخطيط أعصاب",
        "code": "321105"
    },
    {
        "english_name": "Audiometrist",
        "arabic_name": "فني تخطيط سمع",
        "code": "321106"
    },
    {
        "english_name": "Medical Laboratory Technician",
        "arabic_name": "فني مختبر طبي",
        "code": "321201"
    },
    {
        "english_name": "Phlebotomy Technician",
        "arabic_name": "فني سحب دم",
        "code": "321202"
    },
    {
        "english_name": "Medical Physics Technician",
        "arabic_name": "فني فيزياء طبية",
        "code": "321203"
    },
    {
        "english_name": "Molecular Genetics Technician",
        "arabic_name": "فني وراثة جزيئية",
        "code": "321204"
    },
    {
        "english_name": "Pharmacy Technician",
        "arabic_name": "فني صيدلة",
        "code": "321301"
    },
    {
        "english_name": "Dental Laboratory Technicians",
        "arabic_name": "فني معمل أسنان",
        "code": "321401"
    },
    {
        "english_name": "Dental Assistant",
        "arabic_name": "مساعد طبيب أسنان",
        "code": "321402"
    },
    {
        "english_name": "Prosthetic Technician",
        "arabic_name": "فني أطراف صناعية",
        "code": "321403"
    },
    {
        "english_name": "Nurse Technician",
        "arabic_name": "فني تمريض",
        "code": "322101"
    },
    {
        "english_name": "Midwifery Technician",
        "arabic_name": "فني قبالة",
        "code": "322201"
    },
    {
        "english_name": "Orthopedic Technician",
        "arabic_name": "فني تجبير",
        "code": "323001"
    },
    {
        "english_name": "Cupping Technician",
        "arabic_name": "فني حجامة",
        "code": "323002"
    },
    {
        "english_name": "Acupuncture Technician",
        "arabic_name": "فني وخز بالإبر الصينية",
        "code": "323003"
    },
    {
        "english_name": "Veterinary Assistant",
        "arabic_name": "مساعد طب بيطري",
        "code": "324001"
    },
    {
        "english_name": "Oral & Dental Health Therapist",
        "arabic_name": "معالج صحة فم وأسنان",
        "code": "325101"
    },
    {
        "english_name": "Health Information Technician",
        "arabic_name": "فني معلوماتية صحية",
        "code": "325201"
    },
    {
        "english_name": "Medical Coding Technician",
        "arabic_name": "فني ترميز طبي",
        "code": "325202"
    },
    {
        "english_name": "Health Services & Hospitals Management Technician",
        "arabic_name": "فني إدارة خدمات صحية ومستشفيات",
        "code": "325203"
    },
    {
        "english_name": "Epidemics Controller",
        "arabic_name": "مراقب وبائيات",
        "code": "325301"
    },
    {
        "english_name": "Medical Optics Technician",
        "arabic_name": "فني بصريات طبية",
        "code": "325401"
    },
    {
        "english_name": "Ophthalmic Technician",
        "arabic_name": "فني عيون",
        "code": "325402"
    },
    {
        "english_name": "Optician Technician",
        "arabic_name": "فني نظارات",
        "code": "325403"
    },
    {
        "english_name": "Physiotherapy Technician",
        "arabic_name": "فني علاج طبيعي",
        "code": "325501"
    },
    {
        "english_name": "Occupational Therapy Technician",
        "arabic_name": "فني علاج وظيفي",
        "code": "325502"
    },
    {
        "english_name": "Respiratory Therapy Technician",
        "arabic_name": "فني علاج تنفسي",
        "code": "325503"
    },
    {
        "english_name": "Health Care Assistant",
        "arabic_name": "مساعد صحي",
        "code": "325601"
    },
    {
        "english_name": "Occupational Health and Safety Supervisor",
        "arabic_name": "مشرف صحة وسلامة مهنية",
        "code": "325701"
    },
    {
        "english_name": "Environmental Protection Inspector",
        "arabic_name": "مفتش حماية بيئية",
        "code": "325702"
    },
    {
        "english_name": "Public Health Technician",
        "arabic_name": "فني صحة عامة",
        "code": "325703"
    },
    {
        "english_name": "Health Educator",
        "arabic_name": "فني تثقيف صحي",
        "code": "325704"
    },
    {
        "english_name": "Emergency Medical Technician",
        "arabic_name": "فني إسعاف",
        "code": "325801"
    },
    {
        "english_name": "Emergency Services technician",
        "arabic_name": "فني خدمات طبية طارئة",
        "code": "325802"
    },
    {
        "english_name": "Anesthetic Technician",
        "arabic_name": "فني تخدير",
        "code": "325901"
    },
    {
        "english_name": "Operating Room Technician",
        "arabic_name": "فني غرفة عمليات",
        "code": "325902"
    },
    {
        "english_name": "Cardiovascular Technician",
        "arabic_name": "فني تقنية قلب",
        "code": "325903"
    },
    {
        "english_name": "Cardiac Catheterization Technician",
        "arabic_name": "فني قسطرة قلب",
        "code": "325904"
    },
    {
        "english_name": "Cardiac Perfusionist",
        "arabic_name": "فني تروية قلب",
        "code": "325905"
    },
    {
        "english_name": "Dialysis Technician",
        "arabic_name": "فني غسيل كُلى",
        "code": "325906"
    },
    {
        "english_name": "Lithotripsy Technician",
        "arabic_name": "فني تفتيت حصى",
        "code": "325907"
    },
    {
        "english_name": "Nutrition and Dietetic Technician",
        "arabic_name": "فني تغذية",
        "code": "325908"
    },
    {
        "english_name": "Non-clinical Dietetic Technician",
        "arabic_name": "فني علم غذاء غير سريري",
        "code": "325909"
    },
    {
        "english_name": "Sterilization Technician",
        "arabic_name": "فني تعقيم",
        "code": "325910"
    },
    {
        "english_name": "Neurophysiology Technologist",
        "arabic_name": "فني فسيلوجيا عصبية",
        "code": "325911"
    },
    {
        "english_name": "Foreign exchange dealer.",
        "arabic_name": "تاجر عملات أجنبية",
        "code": "331101"
    },
    {
        "english_name": "Securities broker",
        "arabic_name": "وسيط أوراق مالية",
        "code": "331102"
    },
    {
        "english_name": "Loan Officer",
        "arabic_name": "مسؤول طلبات قروض",
        "code": "331201"
    },
    {
        "english_name": "Real-estate Funding Officer",
        "arabic_name": "مسؤول طلبات تمويل عقاري",
        "code": "331202"
    },
    {
        "english_name": "Lease Finance Officer",
        "arabic_name": "مسؤول طلبات التأجير التمويلي",
        "code": "331203"
    },
    {
        "english_name": "Accounts Assistant",
        "arabic_name": "مساعد حسابات",
        "code": "331301"
    },
    {
        "english_name": "Inventory Controller",
        "arabic_name": "مراقب مخزون",
        "code": "331302"
    },
    {
        "english_name": "Statistical controller",
        "arabic_name": "مراقب إحصائي",
        "code": "331401"
    },
    {
        "english_name": "Actuarial Assistant",
        "arabic_name": "مساعد إكتوارية",
        "code": "331402"
    },
    {
        "english_name": "Mathematics Assistant",
        "arabic_name": "مساعد رياضيات",
        "code": "331403"
    },
    {
        "english_name": "Statistical Assistant",
        "arabic_name": "مساعد إحصاء",
        "code": "331404"
    },
    {
        "english_name": "Statistical Surveyor",
        "arabic_name": "مساح إحصائي",
        "code": "331405"
    },
    {
        "english_name": "Medical statistical Technician",
        "arabic_name": "فني إحصاء طبي",
        "code": "331406"
    },
    {
        "english_name": "Certified evaluator",
        "arabic_name": "مقيّم معتمد",
        "code": "331501"
    },
    {
        "english_name": "Insurance Claims adjuster",
        "arabic_name": "مقيِّم مطالبات التأمين",
        "code": "331502"
    },
    {
        "english_name": "Medical Insurance Technician",
        "arabic_name": "فني تأمين طبي",
        "code": "331503"
    },
    {
        "english_name": "Real Estate Appraiser",
        "arabic_name": "مقيِّم عقاري",
        "code": "331504"
    },
    {
        "english_name": "Damage Assessor",
        "arabic_name": "مقيم أضرار",
        "code": "331505"
    },
    {
        "english_name": "Machinery and Equipment Assessor",
        "arabic_name": "مقيم آلات ومعدات",
        "code": "331506"
    },
    {
        "english_name": "Jewelry and Precious Metal Appraiser",
        "arabic_name": "مقيم مصوغات ومعادن نفيسة",
        "code": "331507"
    },
    {
        "english_name": "Insurance Agent",
        "arabic_name": "وكيل تأمين",
        "code": "332101"
    },
    {
        "english_name": "Insurance Broker",
        "arabic_name": "وسيط تأمين",
        "code": "332102"
    },
    {
        "english_name": "Insurance request officer",
        "arabic_name": "مسؤول طلبات التأمين",
        "code": "332103"
    },
    {
        "english_name": "Sales Representative",
        "arabic_name": "مندوب مبيعات",
        "code": "332201"
    },
    {
        "english_name": "Commercial Agent",
        "arabic_name": "وكيل تجاري",
        "code": "332202"
    },
    {
        "english_name": "Private Brand Supplying Specialist",
        "arabic_name": "أخصائي توريد للعلامات التجارية الخاصة",
        "code": "332301"
    },
    {
        "english_name": "Purchasing Representative",
        "arabic_name": "مندوب مشتريات",
        "code": "332302"
    },
    {
        "english_name": "Future Commodity Broker",
        "arabic_name": "وسيط سلع مستقبلية",
        "code": "332401"
    },
    {
        "english_name": "Commodity Broker",
        "arabic_name": "وسيط سلع",
        "code": "332402"
    },
    {
        "english_name": "Shipping broker",
        "arabic_name": "وسيط شحن",
        "code": "332403"
    },
    {
        "english_name": "Freight Forwarder",
        "arabic_name": "وكيل شحن",
        "code": "333101"
    },
    {
        "english_name": "Customs agent",
        "arabic_name": "وكيل جمركي",
        "code": "333102"
    },
    {
        "english_name": "Customs Broker",
        "arabic_name": "مخلص جمركي",
        "code": "333103"
    },
    {
        "english_name": "Catering Official",
        "arabic_name": "مسؤول تموين",
        "code": "333201"
    },
    {
        "english_name": "Events Coordinator",
        "arabic_name": "منسق فعاليات",
        "code": "333202"
    },
    {
        "english_name": "Conference and Exhibition Coordinator",
        "arabic_name": "منسق معارض ومؤتمرات",
        "code": "333203"
    },
    {
        "english_name": "Event Coordinator",
        "arabic_name": "منسق مراسم",
        "code": "333204"
    },
    {
        "english_name": "Recruitment Agent",
        "arabic_name": "وكيل توظيف",
        "code": "333301"
    },
    {
        "english_name": "Labor Contractor",
        "arabic_name": "مقاول عمال",
        "code": "333302"
    },
    {
        "english_name": "Real Estate Supervisor",
        "arabic_name": "مشرف عقار",
        "code": "333401"
    },
    {
        "english_name": "Real Estate Agent",
        "arabic_name": "وكيل عقاري",
        "code": "333402"
    },
    {
        "english_name": "Real estate broker",
        "arabic_name": "وسيط عقاري",
        "code": "333403"
    },
    {
        "english_name": "Publicity and Advertising Agent",
        "arabic_name": "وكيل دعاية وإعلان",
        "code": "333901"
    },
    {
        "english_name": "Auction Organizer",
        "arabic_name": "منظم مزادات",
        "code": "333902"
    },
    {
        "english_name": "Sports Agent",
        "arabic_name": "وكيل رياضي",
        "code": "333903"
    },
    {
        "english_name": "Travel Agent",
        "arabic_name": "وكيل سياحي",
        "code": "333904"
    },
    {
        "english_name": "Tour Operator",
        "arabic_name": "منظم سياحي",
        "code": "333905"
    },
    {
        "english_name": "Vehicle Rental Agent",
        "arabic_name": "وكيل تأجير مركبات",
        "code": "333906"
    },
    {
        "english_name": "Literary Publisher",
        "arabic_name": "ناشر أدبي",
        "code": "333907"
    },
    {
        "english_name": "Artist Agent",
        "arabic_name": "وكيل فنانين",
        "code": "333908"
    },
    {
        "english_name": "Data Entry Supervisor",
        "arabic_name": "مشرف مدخلي البيانات",
        "code": "334101"
    },
    {
        "english_name": "Committees Coordinator",
        "arabic_name": "منسق لجان",
        "code": "334102"
    },
    {
        "english_name": "Committee Secretary",
        "arabic_name": "أمين سر لجنة",
        "code": "334103"
    },
    {
        "english_name": "Office Supervisor",
        "arabic_name": "مشرف مكتب",
        "code": "334104"
    },
    {
        "english_name": "Legal Secretary",
        "arabic_name": "سكرتير قانوني",
        "code": "334201"
    },
    {
        "english_name": "Judicial Circuit Secretary",
        "arabic_name": "أمين سر دائرة قضائية",
        "code": "334202"
    },
    {
        "english_name": "Executive Secretary",
        "arabic_name": "سكرتير تنفيذي",
        "code": "334301"
    },
    {
        "english_name": "Medical Secretary",
        "arabic_name": "سكرتير طبي",
        "code": "334401"
    },
    {
        "english_name": "Ports Inspector",
        "arabic_name": "مفتش منافذ",
        "code": "335101"
    },
    {
        "english_name": "Customs Inspector",
        "arabic_name": "مراقب جمركي",
        "code": "335102"
    },
    {
        "english_name": "Customs Duty Officer",
        "arabic_name": "مسؤول رسوم جمركية",
        "code": "335201"
    },
    {
        "english_name": "Tax Officer",
        "arabic_name": "مسؤول ضرائب",
        "code": "335202"
    },
    {
        "english_name": "Social Aids Officer",
        "arabic_name": "مسؤول إعانات اجتماعية",
        "code": "335301"
    },
    {
        "english_name": "Licenses and Permits Officer",
        "arabic_name": "مسؤول تراخيص وتصاريح",
        "code": "335401"
    },
    {
        "english_name": "Passport Officer",
        "arabic_name": "مسؤول إجراءات جوازات",
        "code": "335402"
    },
    {
        "english_name": "Civil Affairs Officer",
        "arabic_name": "مسؤول إجراءات أحوال مدنية",
        "code": "335403"
    },
    {
        "english_name": "Identification Technician",
        "arabic_name": "فني تحقيق شخصية",
        "code": "335901"
    },
    {
        "english_name": "Forgery detection technician",
        "arabic_name": "فني كشف تزوير",
        "code": "335902"
    },
    {
        "english_name": "Consumer and Investor Protection Officer",
        "arabic_name": "مراقب حماية المستهلك والمستثمر",
        "code": "335903"
    },
    {
        "english_name": "Hotel Controller",
        "arabic_name": "مراقب فنادق",
        "code": "335904"
    },
    {
        "english_name": "Commercial Controller",
        "arabic_name": "مراقب تجاري",
        "code": "335905"
    },
    {
        "english_name": "Catering Controller",
        "arabic_name": "مراقب تموين",
        "code": "335906"
    },
    {
        "english_name": "General Services Controller",
        "arabic_name": "مراقب خدمات عامة",
        "code": "335907"
    },
    {
        "english_name": "Jeweler and stamping technician",
        "arabic_name": "فني مصوغات ودمغة",
        "code": "335908"
    },
    {
        "english_name": "Litigants Bailiff",
        "arabic_name": "محضر خصوم",
        "code": "341103"
    },
    {
        "english_name": "Registrar",
        "arabic_name": "موثق سجل",
        "code": "341104"
    },
    {
        "english_name": "Social Work Assistant",
        "arabic_name": "مساعد خدمة اجتماعية",
        "code": "341201"
    },
    {
        "english_name": "Juvenile Care Assistant",
        "arabic_name": "مساعد رعاية أحداث",
        "code": "341202"
    },
    {
        "english_name": "Youth care Supervisor",
        "arabic_name": "مشرف رعاية شباب",
        "code": "341203"
    },
    {
        "english_name": "Mental Health Assistant",
        "arabic_name": "مساعد صحة نفسية",
        "code": "341204"
    },
    {
        "english_name": "Marriage Registrar",
        "arabic_name": "مأذون عقود أنكحة",
        "code": "341301"
    },
    {
        "english_name": "Prayer Caller",
        "arabic_name": "مؤذن",
        "code": "341302"
    },
    {
        "english_name": "Mosque Controller",
        "arabic_name": "مراقب مساجد",
        "code": "341303"
    },
    {
        "english_name": "Holy Quran Reciter",
        "arabic_name": "مقرئ قرآن كريم",
        "code": "341304"
    },
    {
        "english_name": "Holy Quran Memorizer",
        "arabic_name": "محفظ قرآن كريم",
        "code": "341305"
    },
    {
        "english_name": "Hajj and Umrah Controller",
        "arabic_name": "مراقب حج وعمرة",
        "code": "341306"
    },
    {
        "english_name": "Professional Football Player",
        "arabic_name": "لاعب كرة قدم محترف",
        "code": "342101"
    },
    {
        "english_name": "Professional Ball Game Player",
        "arabic_name": "لاعب رياضة بالكرة محترف",
        "code": "342102"
    },
    {
        "english_name": "Professional Self-Defense Sport Player",
        "arabic_name": "لاعب رياضة دفاع عن النفس محترف",
        "code": "342103"
    },
    {
        "english_name": "Professional Bat-and-Ball game Player",
        "arabic_name": "لاعب رياضة مضرب محترف",
        "code": "342104"
    },
    {
        "english_name": "Professional water sport player",
        "arabic_name": "لاعب رياضة مائية محترف",
        "code": "342105"
    },
    {
        "english_name": "Professional ice sport player",
        "arabic_name": "لاعب رياضة جليدية محترف",
        "code": "342106"
    },
    {
        "english_name": "Professional Motorsport Player",
        "arabic_name": "لاعب سباقات مركبات محترف",
        "code": "342107"
    },
    {
        "english_name": "Professional Equestrian Player",
        "arabic_name": "لاعب فروسية محترف",
        "code": "342108"
    },
    {
        "english_name": "Professional Athletics Player",
        "arabic_name": "لاعب ألعاب قوى محترف",
        "code": "342109"
    },
    {
        "english_name": "Professional Sports Player",
        "arabic_name": "لاعب رياضي محترف",
        "code": "342110"
    },
    {
        "english_name": "Sports Coach",
        "arabic_name": "مدرب رياضي",
        "code": "342201"
    },
    {
        "english_name": "Referee",
        "arabic_name": "حكم رياضي",
        "code": "342202"
    },
    {
        "english_name": "Professional Football Coach",
        "arabic_name": "مدرب كرة قدم محترف",
        "code": "342203"
    },
    {
        "english_name": "Professional Football Referee",
        "arabic_name": "حكم كرة قدم محترف",
        "code": "342204"
    },
    {
        "english_name": "Professional Ball Game Coach",
        "arabic_name": "مدرب رياضة بالكرة محترف",
        "code": "342205"
    },
    {
        "english_name": "Professional Ball Game Referee",
        "arabic_name": "حكم رياضة بالكرة محترف",
        "code": "342206"
    },
    {
        "english_name": "Professional Self-Defense Sport Coach",
        "arabic_name": "مدرب رياضة دفاع عن النفس محترف",
        "code": "342207"
    },
    {
        "english_name": "Professional Self-Defense Sport Referee",
        "arabic_name": "حكم رياضة دفاع عن النفس محترف",
        "code": "342208"
    },
    {
        "english_name": "Professional Bat-and-Ball game Coach",
        "arabic_name": "مدرب رياضة مضرب محترف",
        "code": "342209"
    },
    {
        "english_name": "Professional Bat-and-Ball game Referee",
        "arabic_name": "حكم رياضة مضرب محترف",
        "code": "342210"
    },
    {
        "english_name": "Professional water sport Coach",
        "arabic_name": "مدرب رياضة مائية محترف",
        "code": "342211"
    },
    {
        "english_name": "Professional water sport Referee",
        "arabic_name": "حكم رياضة مائية محترف",
        "code": "342212"
    },
    {
        "english_name": "Professional Ice sport Coach",
        "arabic_name": "مدرب رياضة جليدية محترف",
        "code": "342213"
    },
    {
        "english_name": "Professional Ice sport Referee",
        "arabic_name": "حكم رياضة جليدية محترف",
        "code": "342214"
    },
    {
        "english_name": "Professional Motorsport Coach",
        "arabic_name": "مدرب سباقات مركبات محترف",
        "code": "342215"
    },
    {
        "english_name": "Professional Motorsport Referee",
        "arabic_name": "حكم سباقات مركبات محترف",
        "code": "342216"
    },
    {
        "english_name": "Professional Equestrian Coach",
        "arabic_name": "مدرب فروسية محترف",
        "code": "342217"
    },
    {
        "english_name": "Professional Equestrian Referee",
        "arabic_name": "حكم فروسية محترف",
        "code": "342218"
    },
    {
        "english_name": "Professional Athletics Coach",
        "arabic_name": "مدرب العاب قوى محترف",
        "code": "342219"
    },
    {
        "english_name": "Professional Athletics Referee",
        "arabic_name": "حكم العاب قوى محترف",
        "code": "342220"
    },
    {
        "english_name": "Sports Supervisor",
        "arabic_name": "مشرف رياضي",
        "code": "342221"
    },
    {
        "english_name": "Fitness Coach",
        "arabic_name": "مدرب لياقة بدنية",
        "code": "342301"
    },
    {
        "english_name": "Photographer",
        "arabic_name": "مصور فوتوغرافي",
        "code": "343101"
    },
    {
        "english_name": "Aerial Photographer",
        "arabic_name": "مصور جوي",
        "code": "343102"
    },
    {
        "english_name": "Forensic Photographer",
        "arabic_name": "مصور جنائي",
        "code": "343103"
    },
    {
        "english_name": "Press Photographer",
        "arabic_name": "مصور صحفي",
        "code": "343104"
    },
    {
        "english_name": "Exhibition Design Technician",
        "arabic_name": "فني تصميم معارض",
        "code": "343201"
    },
    {
        "english_name": "Interior Design Technician",
        "arabic_name": "فني تصميم داخلي",
        "code": "343202"
    },
    {
        "english_name": "Museum Technician",
        "arabic_name": "فني متاحف",
        "code": "343301"
    },
    {
        "english_name": "Exhibition Technician",
        "arabic_name": "فني معارض",
        "code": "343302"
    },
    {
        "english_name": "Library Technician",
        "arabic_name": "فني مكتبات",
        "code": "343303"
    },
    {
        "english_name": "Head Chef",
        "arabic_name": "رئيس طهاه",
        "code": "343401"
    },
    {
        "english_name": "Henna Artist",
        "arabic_name": "فني رسم حناء",
        "code": "343501"
    },
    {
        "english_name": "Makeup Artist",
        "arabic_name": "فني ماكياج",
        "code": "343502"
    },
    {
        "english_name": "Filming Location Technician",
        "arabic_name": "فني موقع التصوير",
        "code": "343503"
    },
    {
        "english_name": "Special Effects Technician",
        "arabic_name": "فني مؤثرات خاصة",
        "code": "343504"
    },
    {
        "english_name": "Stamp Technician",
        "arabic_name": "فني طوابع",
        "code": "343505"
    },
    {
        "english_name": "Security Signs & Documents Technician",
        "arabic_name": "فني علامات ووثائق أمنية",
        "code": "343506"
    },
    {
        "english_name": "Documents & Manuscripts Restoration Technician",
        "arabic_name": "فني ترميم وثائق ومخطوطات",
        "code": "343507"
    },
    {
        "english_name": "Monuments Restoration Technician",
        "arabic_name": "فني ترميم آثار",
        "code": "343508"
    },
    {
        "english_name": "Expressive Painter",
        "arabic_name": "رسام تعبيري",
        "code": "343509"
    },
    {
        "english_name": "Instrumentalist",
        "arabic_name": "عازف آلة موسيقية",
        "code": "343510"
    },
    {
        "english_name": "Supporting Actor",
        "arabic_name": "ممثل ثانوي",
        "code": "343511"
    },
    {
        "english_name": "Co-Director",
        "arabic_name": "مساعد مخرج",
        "code": "343512"
    },
    {
        "english_name": "IT Operations Technician",
        "arabic_name": "فني عمليات تقنية معلومات",
        "code": "351101"
    },
    {
        "english_name": "Communications Operations Technician",
        "arabic_name": "فني عمليات اتصالات",
        "code": "351102"
    },
    {
        "english_name": "Digital Printing Technician",
        "arabic_name": "فني طباعة رقمية",
        "code": "351103"
    },
    {
        "english_name": "IT Support Technician",
        "arabic_name": "فني دعم تقنية معلومات",
        "code": "351201"
    },
    {
        "english_name": "Communications Support Technician",
        "arabic_name": "فني دعم اتصالات",
        "code": "351202"
    },
    {
        "english_name": "Software Support Technician",
        "arabic_name": "فني دعم برامج",
        "code": "351203"
    },
    {
        "english_name": "Database Support Technician",
        "arabic_name": "فني دعم قواعد بيانات",
        "code": "351204"
    },
    {
        "english_name": "IT Network Technician",
        "arabic_name": "فني شبكات تقنية معلومات",
        "code": "351301"
    },
    {
        "english_name": "Communications Networks Technician",
        "arabic_name": "فني شبكات اتصالات",
        "code": "351302"
    },
    {
        "english_name": "Communication Systems Technician",
        "arabic_name": "فني نظم اتصالات",
        "code": "351303"
    },
    {
        "english_name": "Computer Systems Technician",
        "arabic_name": "فني نظم حاسب آلي",
        "code": "351304"
    },
    {
        "english_name": "Cybersecurity Assistant",
        "arabic_name": "مساعد أمن سيبراني",
        "code": "351305"
    },
    {
        "english_name": "Website Technician",
        "arabic_name": "فني مواقع إلكترونية",
        "code": "351401"
    },
    {
        "english_name": "Website Administrator",
        "arabic_name": "إداري مواقع إلكترونية",
        "code": "351402"
    },
    {
        "english_name": "Website Maintenance Technician",
        "arabic_name": "فني صيانة مواقع إلكترونية",
        "code": "351403"
    },
    {
        "english_name": "Audio & Video Editing Technician",
        "arabic_name": "فني تحرير صوتيات ومرئيات",
        "code": "352101"
    },
    {
        "english_name": "Recording Technician",
        "arabic_name": "فني تسجيل",
        "code": "352102"
    },
    {
        "english_name": "Radio Broadcast Technician",
        "arabic_name": "فني بث اذاعي",
        "code": "352103"
    },
    {
        "english_name": "TV Broadcast Technician",
        "arabic_name": "فني إرسال تلفزيوني",
        "code": "352104"
    },
    {
        "english_name": "Audio Technician",
        "arabic_name": "فني صوت",
        "code": "352105"
    },
    {
        "english_name": "Lighting Technician",
        "arabic_name": "فني إضاءة",
        "code": "352106"
    },
    {
        "english_name": "Cinematographer",
        "arabic_name": "فني تصوير سينمائي",
        "code": "352107"
    },
    {
        "english_name": "Videographer",
        "arabic_name": "فني تصوير فيديو",
        "code": "352108"
    },
    {
        "english_name": "Montage Technician",
        "arabic_name": "فني مونتاج",
        "code": "352109"
    },
    {
        "english_name": "Dubbing Technician",
        "arabic_name": "فني دبلجة",
        "code": "352110"
    },
    {
        "english_name": "Shows Linking Technician",
        "arabic_name": "فني ربط فقرات",
        "code": "352111"
    },
    {
        "english_name": "Wired Communication Engineering Technician",
        "arabic_name": "فني هندسة اتصالات سلكية",
        "code": "352201"
    },
    {
        "english_name": "Wireless Communication Engineering Technician",
        "arabic_name": "فني هندسة اتصالات لاسلكية",
        "code": "352202"
    },
    {
        "english_name": "Government Relations Clerk",
        "arabic_name": "كاتب علاقات حكومية",
        "code": "411001"
    },
    {
        "english_name": "Registry Clerk",
        "arabic_name": "كاتب سجل",
        "code": "411002"
    },
    {
        "english_name": "Administrative Assistant",
        "arabic_name": "مساعد إداري",
        "code": "412001"
    },
    {
        "english_name": "Secretary",
        "arabic_name": "سكرتير",
        "code": "412002"
    },
    {
        "english_name": "Shorthand Writer",
        "arabic_name": "كاتب اختزال",
        "code": "413101"
    },
    {
        "english_name": "Printing Technician and Proofreader",
        "arabic_name": "طباع",
        "code": "413102"
    },
    {
        "english_name": "Data Entry Clerk",
        "arabic_name": "مدخل بيانات",
        "code": "413201"
    },
    {
        "english_name": "Teller",
        "arabic_name": "صراف",
        "code": "421101"
    },
    {
        "english_name": "Correspondence Writer",
        "arabic_name": "كاتب بريدي",
        "code": "421102"
    },
    {
        "english_name": "Currency Exchange Clerk",
        "arabic_name": "صراف عملات",
        "code": "421103"
    },
    {
        "english_name": "Fundraiser",
        "arabic_name": "جامع تبرعات",
        "code": "421401"
    },
    {
        "english_name": "Collector",
        "arabic_name": "محصل",
        "code": "421402"
    },
    {
        "english_name": "Land Reservation Host",
        "arabic_name": "مضيف أرضي للحجوزات",
        "code": "422101"
    },
    {
        "english_name": "Travel Clerk",
        "arabic_name": "كاتب استعلامات سياحية",
        "code": "422102"
    },
    {
        "english_name": "Ticket Clerk",
        "arabic_name": "كاتب تذاكر سفر",
        "code": "422103"
    },
    {
        "english_name": "Call Center Clerk",
        "arabic_name": "كاتب مركز اتصالات",
        "code": "422201"
    },
    {
        "english_name": "Customer Service Center Inquiry Clerk",
        "arabic_name": "كاتب استعلامات مركز خدمة عملاء",
        "code": "422202"
    },
    {
        "english_name": "Call Center Operator",
        "arabic_name": "مأمور سنترال",
        "code": "422301"
    },
    {
        "english_name": "Telephone Exchange Operator",
        "arabic_name": "مشغل مقسم هاتف",
        "code": "422302"
    },
    {
        "english_name": "Telephone Communication Clerk",
        "arabic_name": "كاتب اتصال",
        "code": "422303"
    },
    {
        "english_name": "Hotel Receptionist",
        "arabic_name": "موظف استقبال فندق",
        "code": "422401"
    },
    {
        "english_name": "Customer Complaints Clerk",
        "arabic_name": "كاتب استعلامات",
        "code": "422501"
    },
    {
        "english_name": "Inquiry Clerk",
        "arabic_name": "كاتب شكاوى",
        "code": "422502"
    },
    {
        "english_name": "Receptionist",
        "arabic_name": "موظف استقبال",
        "code": "422601"
    },
    {
        "english_name": "Patient Receptionist",
        "arabic_name": "كاتب استقبال مرضى",
        "code": "422602"
    },
    {
        "english_name": "Field Survey Clerk",
        "arabic_name": "كاتب مسوحات ميدانية",
        "code": "422701"
    },
    {
        "english_name": "Data Collector",
        "arabic_name": "جامع بيانات",
        "code": "422702"
    },
    {
        "english_name": "Hospital Admission Clerk",
        "arabic_name": "كاتب إدخال مستشفى",
        "code": "422901"
    },
    {
        "english_name": "Customer Data Entry Clerk",
        "arabic_name": "كاتب بيانات عملاء",
        "code": "422902"
    },
    {
        "english_name": "Accounting Clerk",
        "arabic_name": "كاتب حسابات",
        "code": "431101"
    },
    {
        "english_name": "Financial Clerk",
        "arabic_name": "كاتب مالي",
        "code": "431201"
    },
    {
        "english_name": "Insurance Clerk",
        "arabic_name": "كاتب تأمين",
        "code": "431202"
    },
    {
        "english_name": "Salary Clerk",
        "arabic_name": "كاتب رواتب",
        "code": "431301"
    },
    {
        "english_name": "Storekeeper",
        "arabic_name": "أمين مخزن",
        "code": "432101"
    },
    {
        "english_name": "Shipping Clerk",
        "arabic_name": "كاتب شحن",
        "code": "432102"
    },
    {
        "english_name": "Inventory Clerk",
        "arabic_name": "كاتب حركة مخزون",
        "code": "432103"
    },
    {
        "english_name": "Production Clerk",
        "arabic_name": "كاتب إنتاج",
        "code": "432201"
    },
    {
        "english_name": "Transportation Operations Clerk",
        "arabic_name": "كاتب عمليات نقل",
        "code": "432301"
    },
    {
        "english_name": "Parcel Post Clerk",
        "arabic_name": "كاتب خدمات طرود بريدية",
        "code": "432302"
    },
    {
        "english_name": "Library Clerk",
        "arabic_name": "كاتب مكتبة",
        "code": "441101"
    },
    {
        "english_name": "Mail Distributor",
        "arabic_name": "موزع بريد",
        "code": "441201"
    },
    {
        "english_name": "Mail Sorter",
        "arabic_name": "فارز بريدي",
        "code": "441202"
    },
    {
        "english_name": "Mail Operations Supervisor",
        "arabic_name": "مشرف عمليات بريدية",
        "code": "441203"
    },
    {
        "english_name": "Data Encoder",
        "arabic_name": "مرمز بيانات",
        "code": "441301"
    },
    {
        "english_name": "Data Auditor",
        "arabic_name": "كاتب تدقيق بيانات",
        "code": "441302"
    },
    {
        "english_name": "Data Encoders/Decoder",
        "arabic_name": "كاتب شيفرة",
        "code": "441303"
    },
    {
        "english_name": "Customs Categorizer",
        "arabic_name": "مبند جمركي",
        "code": "441304"
    },
    {
        "english_name": "Transcriber",
        "arabic_name": "ناسخ",
        "code": "441401"
    },
    {
        "english_name": "Archive Clerk",
        "arabic_name": "كاتب حفظ ملفات",
        "code": "441501"
    },
    {
        "english_name": "Microfilm Clerk",
        "arabic_name": "كاتب تصوير مصغرات فيلمية",
        "code": "441502"
    },
    {
        "english_name": "Human Resources Clerk",
        "arabic_name": "كاتب موارد بشرية",
        "code": "441601"
    },
    {
        "english_name": "Correspondence Clerk",
        "arabic_name": "كاتب مراسلات",
        "code": "441901"
    },
    {
        "english_name": "Flight Attendant",
        "arabic_name": "مضيف طيران",
        "code": "511101"
    },
    {
        "english_name": "Marine Stewardess",
        "arabic_name": "مضيف بحري",
        "code": "511102"
    },
    {
        "english_name": "Transportation Tickets Seller",
        "arabic_name": "قاطع تذاكر نقل",
        "code": "511201"
    },
    {
        "english_name": "Transportation Ticket Inspector",
        "arabic_name": "مفتش تذاكر نقل",
        "code": "511202"
    },
    {
        "english_name": "Porter",
        "arabic_name": "مراقب حقائب",
        "code": "511203"
    },
    {
        "english_name": "Tour Guide",
        "arabic_name": "مرشد سياحي",
        "code": "511301"
    },
    {
        "english_name": "Museum Guide",
        "arabic_name": "مرشد متحف",
        "code": "511302"
    },
    {
        "english_name": "Site Guide",
        "arabic_name": "مرشد موقع",
        "code": "511303"
    },
    {
        "english_name": "Chef",
        "arabic_name": "طاهي",
        "code": "512001"
    },
    {
        "english_name": "Pantry Chef",
        "arabic_name": "محضر أطعمة باردة",
        "code": "512002"
    },
    {
        "english_name": "Chef in Transportations",
        "arabic_name": "طاهي وسائل نقل",
        "code": "512003"
    },
    {
        "english_name": "House Food Chef",
        "arabic_name": "طاهي مأكولات منزلية",
        "code": "512004"
    },
    {
        "english_name": "Waiter",
        "arabic_name": "مضيّف مطعم",
        "code": "513101"
    },
    {
        "english_name": "Barman",
        "arabic_name": "ساقي",
        "code": "513201"
    },
    {
        "english_name": "Barista",
        "arabic_name": "معد قهوة",
        "code": "513202"
    },
    {
        "english_name": "Barber",
        "arabic_name": "حلاق",
        "code": "514101"
    },
    {
        "english_name": "Hairdresser",
        "arabic_name": "مصفف شعر",
        "code": "514102"
    },
    {
        "english_name": "Skin Care Specialist",
        "arabic_name": "مختص عناية بشرة",
        "code": "514201"
    },
    {
        "english_name": "Nail Care Specialist",
        "arabic_name": "مختص عناية أظافر",
        "code": "514202"
    },
    {
        "english_name": "Cosmetician",
        "arabic_name": "ممكيج",
        "code": "514203"
    },
    {
        "english_name": "Health Club Attendant",
        "arabic_name": "مضيف نادي صحي",
        "code": "514204"
    },
    {
        "english_name": "House Agricultural Specialist",
        "arabic_name": "أخصائي زراعي منزلي",
        "code": "213208"
    },
    {
        "english_name": "House Nurse",
        "arabic_name": "ممرض منزلي",
        "code": "222117"
    },
    {
        "english_name": "Private Physiotherapy Specialist",
        "arabic_name": "أخصائي علاج طبيعي خاص",
        "code": "226406"
    },
    {
        "english_name": "Service household Specialist",
        "arabic_name": "أخصائي إدارة خدمات منزلي",
        "code": "242132"
    },
    {
        "english_name": "houses Maintenance Technician",
        "arabic_name": "فني صيانة منزلي",
        "code": "311215"
    },
    {
        "english_name": "Private Tugboats Captain",
        "arabic_name": "ربان قاطرة مراكب خاص",
        "code": "315209"
    },
    {
        "english_name": "Private purchasing Represent",
        "arabic_name": "مندوب مشتريات خاص",
        "code": "332303"
    },
    {
        "english_name": "Private sports Coach",
        "arabic_name": "مدرب رياضي خاص",
        "code": "342302"
    },
    {
        "english_name": "House Secretary",
        "arabic_name": "سكرتير منزلي",
        "code": "412003"
    },
    {
        "english_name": "house Call Center Operator",
        "arabic_name": "مأمور سنترال منزلي",
        "code": "422304"
    },
    {
        "english_name": "House Barista",
        "arabic_name": "معد قهوة منزلي",
        "code": "513203"
    },
    {
        "english_name": "House Hairdresser",
        "arabic_name": "مصفف شعر منزلي",
        "code": "514103"
    },
    {
        "english_name": "house Cosmetician",
        "arabic_name": "مختص تجميل ومكياج منزلي",
        "code": "514205"
    },
    {
        "english_name": "Cleaning and Housekeeping Supervisor",
        "arabic_name": "مشرف تنظيف وتدبير",
        "code": "515101"
    },
    {
        "english_name": "Residence Supervisor",
        "arabic_name": "مشرف مسكن",
        "code": "515102"
    },
    {
        "english_name": "Housekeeping Worker",
        "arabic_name": "عامل تدبير منزلي",
        "code": "515201"
    },
    {
        "english_name": "Butler",
        "arabic_name": "كبير الخدم",
        "code": "515202"
    },
    {
        "english_name": "Guest House keeper",
        "arabic_name": "مدبر بيت ضيافة",
        "code": "515203"
    },
    {
        "english_name": "Janitor",
        "arabic_name": "بواب",
        "code": "515301"
    },
    {
        "english_name": "House Janitor",
        "arabic_name": "حارس منزلي",
        "code": "515302"
    },
    {
        "english_name": "Private animal trainer",
        "arabic_name": "سائس ومدرب حيوانات خاص",
        "code": "516409"
    },
    {
        "english_name": "House Babysitter",
        "arabic_name": "مُربي أطفال منزلي",
        "code": "531104"
    },
    {
        "english_name": "House Farmer",
        "arabic_name": "مزارع منزلي",
        "code": "611307"
    },
    {
        "english_name": "House Tailor",
        "arabic_name": "خياط منزلي",
        "code": "753303"
    },
    {
        "english_name": "House Worker",
        "arabic_name": "عامل منزلي",
        "code": "911102"
    },
    {
        "english_name": "House Kitchen worker",
        "arabic_name": "عامل مطبخ منزلي",
        "code": "941203"
    },
    {
        "english_name": "Nursemaid",
        "arabic_name": "مربية",
        "code": "6132125"
    },
    {
        "english_name": "Servant",
        "arabic_name": "عامل عناية شخصية",
        "code": "6132165"
    },
    {
        "english_name": "Personal Tutor",
        "arabic_name": "مدرس  خاص",
        "code": "6411062"
    },
    {
        "english_name": "Home Cook",
        "arabic_name": "طباخ منزلي",
        "code": "6411115"
    },
    {
        "english_name": "Home Manager",
        "arabic_name": "مدير منزل",
        "code": "6411135"
    },
    {
        "english_name": "Food Preperation Worker",
        "arabic_name": "سفرجي منزلي",
        "code": "6411165"
    },
    {
        "english_name": "Home Butler",
        "arabic_name": "مباشر منزلي",
        "code": "6411175"
    },
    {
        "english_name": "Special speaking and hearing specialist",
        "arabic_name": "اخصائي نطق وسمع خاص",
        "code": "6411221"
    },
    {
        "english_name": "Home Nanny",
        "arabic_name": "مربية منزلية",
        "code": "6411245"
    },
    {
        "english_name": "Cleaning Worker",
        "arabic_name": "عامل نظافة",
        "code": "6411255"
    },
    {
        "english_name": "Personal Worker",
        "arabic_name": "مساعد شخصي",
        "code": "6411264"
    },
    {
        "english_name": "Support Worker",
        "arabic_name": "عامل مساند",
        "code": "6411275"
    },
    {
        "english_name": "Personal Driver",
        "arabic_name": "سائق خاص",
        "code": "9141055"
    },
    {
        "english_name": "Personal Escort",
        "arabic_name": "مرافق شخصي",
        "code": "516201"
    },
    {
        "english_name": "Mortician",
        "arabic_name": "مجهز موتى",
        "code": "516301"
    },
    {
        "english_name": "Funeral Director",
        "arabic_name": "محضر جنازة",
        "code": "516302"
    },
    {
        "english_name": "Taxidermist",
        "arabic_name": "محنط حيوانات",
        "code": "516303"
    },
    {
        "english_name": "Groom",
        "arabic_name": "سائس حيوانات",
        "code": "516401"
    },
    {
        "english_name": "Animal Trainer",
        "arabic_name": "مدرب حيوانات",
        "code": "516402"
    },
    {
        "english_name": "Stableman",
        "arabic_name": "سائس خيل",
        "code": "516403"
    },
    {
        "english_name": "Cameleer",
        "arabic_name": "هجّان",
        "code": "516404"
    },
    {
        "english_name": "Bird Trainer",
        "arabic_name": "مدرب طيور",
        "code": "516405"
    },
    {
        "english_name": "Falcon Trainer",
        "arabic_name": "مدرب صقور",
        "code": "516406"
    },
    {
        "english_name": "Zookeeper",
        "arabic_name": "حارس حديقة حيوان",
        "code": "516407"
    },
    {
        "english_name": "Reserve Animal Keeper",
        "arabic_name": "راعي حيوانات محمية",
        "code": "516408"
    },
    {
        "english_name": "Driving Instructor",
        "arabic_name": "مدرب القيادة",
        "code": "516501"
    },
    {
        "english_name": "Heavy Vehicle Driving Instructor",
        "arabic_name": "مدرب قيادة مركبات الثقيل",
        "code": "516502"
    },
    {
        "english_name": "Desert Guide",
        "arabic_name": "مرشد صحراء",
        "code": "516901"
    },
    {
        "english_name": "Fashion Guide",
        "arabic_name": "مرشد موضة",
        "code": "516902"
    },
    {
        "english_name": "Stall seller",
        "arabic_name": "بائع كشك",
        "code": "521101"
    },
    {
        "english_name": "Food Peddler",
        "arabic_name": "بائع طعام متجول",
        "code": "521201"
    },
    {
        "english_name": "Store Keeper",
        "arabic_name": "أمين متجر",
        "code": "522101"
    },
    {
        "english_name": "Grocer",
        "arabic_name": "بقال",
        "code": "522102"
    },
    {
        "english_name": "Digital Dealer",
        "arabic_name": "تاجر رقمي",
        "code": "522103"
    },
    {
        "english_name": "Shop Monitor",
        "arabic_name": "مراقب متجر",
        "code": "522201"
    },
    {
        "english_name": "Seller",
        "arabic_name": "بائع",
        "code": "522301"
    },
    {
        "english_name": "Food and Beverage Seller",
        "arabic_name": "بائع مأكولات ومشروبات",
        "code": "522302"
    },
    {
        "english_name": "Spice Seller",
        "arabic_name": "عطار",
        "code": "522303"
    },
    {
        "english_name": "Clothes Seller",
        "arabic_name": "بائع ملابس جاهزة",
        "code": "522304"
    },
    {
        "english_name": "Lingerie Female Seller",
        "arabic_name": "بائعة ملابس داخلية نسائية",
        "code": "522305"
    },
    {
        "english_name": "Shoes and Bags Seller",
        "arabic_name": "بائع احذية وحقائب",
        "code": "522306"
    },
    {
        "english_name": "Perfume Seller",
        "arabic_name": "بائع عطور",
        "code": "522307"
    },
    {
        "english_name": "Cosmetics and Toiletries Seller",
        "arabic_name": "بائع مستحضرات وادوات تجميل",
        "code": "522308"
    },
    {
        "english_name": "Sewing and Knitting Supplies Seller",
        "arabic_name": "بائع لوازم خياطة وحياكة",
        "code": "522309"
    },
    {
        "english_name": "Furniture Seller",
        "arabic_name": "بائع اثاث",
        "code": "522310"
    },
    {
        "english_name": "Textile Seller",
        "arabic_name": "بائع منسوجات",
        "code": "522311"
    },
    {
        "english_name": "Seller of Household Appliances and Tools",
        "arabic_name": "بائع ادوات واجهزة منزلية",
        "code": "522312"
    },
    {
        "english_name": "Jewelry Seller",
        "arabic_name": "بائع مجوهرات",
        "code": "522313"
    },
    {
        "english_name": "Watch Seller",
        "arabic_name": "بائع ساعات",
        "code": "522314"
    },
    {
        "english_name": "Seller of Musical Instruments",
        "arabic_name": "بائع ادوات موسيقية",
        "code": "522315"
    },
    {
        "english_name": "Seller of Flowers and Plants",
        "arabic_name": "بائع زهور ونباتات",
        "code": "522316"
    },
    {
        "english_name": "Seller of Agricultural Supplies",
        "arabic_name": "بائع لوازم زراعية",
        "code": "522317"
    },
    {
        "english_name": "Seller of Building Materials",
        "arabic_name": "بائع مواد انشائية",
        "code": "522318"
    },
    {
        "english_name": "Vehicles Seller",
        "arabic_name": "بائع مركبات",
        "code": "522319"
    },
    {
        "english_name": "Seller of Vehicles’ Spare Parts",
        "arabic_name": "بائع قطع غيار مركبات",
        "code": "522320"
    },
    {
        "english_name": "Seller of Vehicles Supplies",
        "arabic_name": "بائع لوازم مركبات",
        "code": "522321"
    },
    {
        "english_name": "Cashier",
        "arabic_name": "موظف صندوق محاسبة",
        "code": "523001"
    },
    {
        "english_name": "Ticket Seller",
        "arabic_name": "بائع تذاكر",
        "code": "523002"
    },
    {
        "english_name": "Model",
        "arabic_name": "عارض أزياء",
        "code": "524101"
    },
    {
        "english_name": "Exhibitor",
        "arabic_name": "عارض",
        "code": "524102"
    },
    {
        "english_name": "Product Coordinator",
        "arabic_name": "منسق منتجات",
        "code": "524201"
    },
    {
        "english_name": "Direct Seller",
        "arabic_name": "بائع مباشر",
        "code": "524301"
    },
    {
        "english_name": "Teleseller",
        "arabic_name": "بائع هاتفي",
        "code": "524401"
    },
    {
        "english_name": "Gas Station Attendant",
        "arabic_name": "عامل محطة وقود",
        "code": "524501"
    },
    {
        "english_name": "Port Worker",
        "arabic_name": "عامل مرفأ",
        "code": "524502"
    },
    {
        "english_name": "Food & Beverage’s Counter Server",
        "arabic_name": "عامل كاونتر مأكولات ومشروبات",
        "code": "524601"
    },
    {
        "english_name": "Vehicles’ Lessor",
        "arabic_name": "مؤجر مركبات",
        "code": "524901"
    },
    {
        "english_name": "Seller of Gas Cylinders",
        "arabic_name": "بائع أسطوانات غاز",
        "code": "524902"
    },
    {
        "english_name": "Seller of Fuelwood and Coal",
        "arabic_name": "بائع فحم وخشب وقود",
        "code": "524903"
    },
    {
        "english_name": "Peddler-Green Grocer",
        "arabic_name": "بائع خضار وفاكهة متجول",
        "code": "524904"
    },
    {
        "english_name": "Market Seller",
        "arabic_name": "بائع أسواق",
        "code": "524905"
    },
    {
        "english_name": "Child-Care Worker",
        "arabic_name": "مسؤول رعاية أطفال",
        "code": "531101"
    },
    {
        "english_name": "Babysitter",
        "arabic_name": "مُربية أطفال",
        "code": "531102"
    },
    {
        "english_name": "Children Caregiver",
        "arabic_name": "حاضنة أطفال",
        "code": "531103"
    },
    {
        "english_name": "Teacher Assistant",
        "arabic_name": "مساعد معلم",
        "code": "531201"
    },
    {
        "english_name": "Patient-Care Assistant",
        "arabic_name": "مساعد رعاية مرضى",
        "code": "532101"
    },
    {
        "english_name": "Elderly-Care Assistant",
        "arabic_name": "مساعد رعاية مسنين",
        "code": "532102"
    },
    {
        "english_name": "Disabled Persons-Care Assistant",
        "arabic_name": "مساعد رعاية ذوي إعاقة",
        "code": "532103"
    },
    {
        "english_name": "Household Patient-Care Assistant",
        "arabic_name": "مساعد رعاية مرضى منزلي",
        "code": "532201"
    },
    {
        "english_name": "Servant",
        "arabic_name": "عامل عناية شخصية",
        "code": "532202"
    },
    {
        "english_name": "Phlebotomist",
        "arabic_name": "فصَّاد",
        "code": "532901"
    },
    {
        "english_name": "First Aid Assistant",
        "arabic_name": "مساعد إسعافات أولية",
        "code": "532902"
    },
    {
        "english_name": "Medical Imaging Assistant",
        "arabic_name": "مساعد تصوير طبي",
        "code": "532903"
    },
    {
        "english_name": "Extinguishing Worker",
        "arabic_name": "إطفائي",
        "code": "541101"
    },
    {
        "english_name": "Civil Defense Rescuer",
        "arabic_name": "منقذ دفاع مدني",
        "code": "541102"
    },
    {
        "english_name": "Policeman",
        "arabic_name": "شرطي",
        "code": "541201"
    },
    {
        "english_name": "Prison Guard",
        "arabic_name": "حارس سجن",
        "code": "541301"
    },
    {
        "english_name": "Sharia Sanctions Executor",
        "arabic_name": "منفذ عقوبات شرعية",
        "code": "541302"
    },
    {
        "english_name": "Security Cameras’ Observer",
        "arabic_name": "مراقب كاميرات أمنية",
        "code": "541401"
    },
    {
        "english_name": "Security Guard",
        "arabic_name": "حارس أمن",
        "code": "541402"
    },
    {
        "english_name": "Personal Guard",
        "arabic_name": "حارس شخصي",
        "code": "541403"
    },
    {
        "english_name": "Lifeguard",
        "arabic_name": "منقذ سباحة",
        "code": "541901"
    },
    {
        "english_name": "Coastguard",
        "arabic_name": "خفير السواحل",
        "code": "541902"
    },
    {
        "english_name": "Guard of Natural Reserve",
        "arabic_name": "حارس محمية طبيعية",
        "code": "541903"
    },
    {
        "english_name": "Guard of Pedestrian Walkway",
        "arabic_name": "حارس ممر مشاة",
        "code": "541904"
    },
    {
        "english_name": "Crops Farmer",
        "arabic_name": "مزارع محاصيل",
        "code": "611101"
    },
    {
        "english_name": "Greenhouses Planter",
        "arabic_name": "مزارع صوب",
        "code": "611102"
    },
    {
        "english_name": "Grain Farmer",
        "arabic_name": "مزارع حبوب",
        "code": "611103"
    },
    {
        "english_name": "Vegetables Farmer",
        "arabic_name": "مزارع خضراوات",
        "code": "611104"
    },
    {
        "english_name": "Farm Supervisor",
        "arabic_name": "مشرف مزرعة",
        "code": "611105"
    },
    {
        "english_name": "Tree & Shrubs Planter",
        "arabic_name": "مزارع أشجار وشجيرات",
        "code": "611201"
    },
    {
        "english_name": "An Arborist",
        "arabic_name": "مزارع تقليم",
        "code": "611202"
    },
    {
        "english_name": "Trees Grafting Planter",
        "arabic_name": "مزارع تطعيم أشجار",
        "code": "611203"
    },
    {
        "english_name": "Palms Grower",
        "arabic_name": "مزارع نخيل",
        "code": "611204"
    },
    {
        "english_name": "Horticultural Farmer",
        "arabic_name": "مزارع بستنة",
        "code": "611301"
    },
    {
        "english_name": "Nursery Farmer",
        "arabic_name": "مزارع مشاتل",
        "code": "611302"
    },
    {
        "english_name": "Green Spaces Farmer",
        "arabic_name": "مزارع مساحات خضراء",
        "code": "611303"
    },
    {
        "english_name": "Seeds Farmer",
        "arabic_name": "مزارع بذور وتقاوي",
        "code": "611304"
    },
    {
        "english_name": "Mushroom Cultivator",
        "arabic_name": "مزارع فطر",
        "code": "611305"
    },
    {
        "english_name": "MAPs Grower",
        "arabic_name": "مزارع نباتات طبية وعطرية",
        "code": "611306"
    },
    {
        "english_name": "Mixed Crops Grower",
        "arabic_name": "مزارع محاصيل مختلطة",
        "code": "611401"
    },
    {
        "english_name": "Animal Raiser",
        "arabic_name": "مُربي حيوانات",
        "code": "612101"
    },
    {
        "english_name": "Stock Farmer",
        "arabic_name": "مربي ماشية",
        "code": "612102"
    },
    {
        "english_name": "Cattle Herder",
        "arabic_name": "راعي ماشية",
        "code": "612103"
    },
    {
        "english_name": "Milkmaid",
        "arabic_name": "حلّاب",
        "code": "612104"
    },
    {
        "english_name": "Shearer",
        "arabic_name": "جزّاز صوف",
        "code": "612105"
    },
    {
        "english_name": "Camel Breeder",
        "arabic_name": "مربي إبل",
        "code": "612106"
    },
    {
        "english_name": "Horses Breeder",
        "arabic_name": "مربي خيول",
        "code": "612107"
    },
    {
        "english_name": "Poultry Breeder",
        "arabic_name": "مربي دواجن",
        "code": "612201"
    },
    {
        "english_name": "Bird Breeder",
        "arabic_name": "مربي طيور",
        "code": "612202"
    },
    {
        "english_name": "Beekeeper",
        "arabic_name": "نحّال",
        "code": "612301"
    },
    {
        "english_name": "Silkworm Rearer",
        "arabic_name": "مربي دودة القز",
        "code": "612302"
    },
    {
        "english_name": "Ostrich Breeder",
        "arabic_name": "مربي نعام",
        "code": "612901"
    },
    {
        "english_name": "Pet Birds Breeder",
        "arabic_name": "مربي طيور زينة",
        "code": "612902"
    },
    {
        "english_name": "Falcon Breeder",
        "arabic_name": "مربي صقور",
        "code": "612903"
    },
    {
        "english_name": "Vegetoanimal Production Farmer",
        "arabic_name": "مزارع إنتاج نباتي حيواني",
        "code": "613001"
    },
    {
        "english_name": "Forests Farmer",
        "arabic_name": "مزارع غابات",
        "code": "621001"
    },
    {
        "english_name": "Pasture Farmer",
        "arabic_name": "مزارع مراعي",
        "code": "621002"
    },
    {
        "english_name": "Lumberjack",
        "arabic_name": "حطَاب",
        "code": "621003"
    },
    {
        "english_name": "Collier",
        "arabic_name": "فحَام",
        "code": "621004"
    },
    {
        "english_name": "Fish Farmer",
        "arabic_name": "مزارع أسماك",
        "code": "622101"
    },
    {
        "english_name": "Crustacean Farmers",
        "arabic_name": "مزارع قشريات",
        "code": "622102"
    },
    {
        "english_name": "Algae Farmer",
        "arabic_name": "مزارع طحالب",
        "code": "622103"
    },
    {
        "english_name": "Fishkeeper",
        "arabic_name": "مربي أسماك زينة",
        "code": "622104"
    },
    {
        "english_name": "Aquatic Farm Fisher",
        "arabic_name": "صياد مزرعة مائية",
        "code": "622201"
    },
    {
        "english_name": "Coastal Fisher",
        "arabic_name": "صياد أسماك ساحلي",
        "code": "622202"
    },
    {
        "english_name": "Crustacean Fisher",
        "arabic_name": "صياد قشريات",
        "code": "622203"
    },
    {
        "english_name": "Coastal Fishing Boat Captain",
        "arabic_name": "قائد مركب صيد ساحلي",
        "code": "622204"
    },
    {
        "english_name": "High Seas Fisher",
        "arabic_name": "صياد أعالي البحار",
        "code": "622301"
    },
    {
        "english_name": "Fishing Vessel Captain",
        "arabic_name": "قائد سفينة صيد",
        "code": "622302"
    },
    {
        "english_name": "Bushmeat Hunter",
        "arabic_name": "صياد طرائد",
        "code": "622401"
    },
    {
        "english_name": "Self-Sufficient Corps Farmer",
        "arabic_name": "مزارع اكتفاء ذاتي محاصيل",
        "code": "631001"
    },
    {
        "english_name": "Animal Breeder For Self-Sufficiency",
        "arabic_name": "مربي اكتفاء ذاتي حيوانات",
        "code": "632001"
    },
    {
        "english_name": "Farmer of Corps & Animal Self-Sufficient Farm",
        "arabic_name": "مزارع اكتفاء ذاتي مزرعة محاصيل وحيوانات",
        "code": "633001"
    },
    {
        "english_name": "Self-Sufficient Fisher",
        "arabic_name": "صياد اكتفاء ذاتي أسماك",
        "code": "634001"
    },
    {
        "english_name": "Crustacean Self-Sufficient Fisher",
        "arabic_name": "صياد اكتفاء ذاتي قشريات",
        "code": "634002"
    },
    {
        "english_name": "Bushmeat Self-Sufficient Hunter",
        "arabic_name": "صياد اكتفاء ذاتي طرائد",
        "code": "634003"
    },
    {
        "english_name": "Subsistence Wild Fruits and Plants Collector",
        "arabic_name": "جامع ثمار ونباتات برية للاكتفاء الذاتي",
        "code": "634004"
    },
    {
        "english_name": "Builder",
        "arabic_name": "بناء",
        "code": "711101"
    },
    {
        "english_name": "Clay mason",
        "arabic_name": "بناء طين",
        "code": "711102"
    },
    {
        "english_name": "Brick mason",
        "arabic_name": "بنّاء طوب",
        "code": "711201"
    },
    {
        "english_name": "Chimneys builder",
        "arabic_name": "بناء مداخن",
        "code": "711202"
    },
    {
        "english_name": "Stone mason",
        "arabic_name": "بناء حجر",
        "code": "711301"
    },
    {
        "english_name": "Stone engraver",
        "arabic_name": "نقّاش حجر",
        "code": "711302"
    },
    {
        "english_name": "Stone cutter",
        "arabic_name": "قاطع احجار",
        "code": "711303"
    },
    {
        "english_name": "Concrete finisher",
        "arabic_name": "عامل خرسانة",
        "code": "711401"
    },
    {
        "english_name": "Ready-mixed concrete finisher",
        "arabic_name": "بناء خرسانة جاهزة",
        "code": "711402"
    },
    {
        "english_name": "Plasterer",
        "arabic_name": "مليّس",
        "code": "711403"
    },
    {
        "english_name": "Mosaic Forming and pouring worker",
        "arabic_name": "عامل تشكيل وصب الموزاييك",
        "code": "711404"
    },
    {
        "english_name": "Carpenter",
        "arabic_name": "نجّار",
        "code": "711501"
    },
    {
        "english_name": "Construction formwork Carpenter.",
        "arabic_name": "نجار قوالب انشائية",
        "code": "711502"
    },
    {
        "english_name": "Wooden formwork carpenter",
        "arabic_name": "نجار هياكل خشبية",
        "code": "711503"
    },
    {
        "english_name": "Ship Carpenter",
        "arabic_name": "نجار سفن",
        "code": "711504"
    },
    {
        "english_name": "Scaffold Laborer",
        "arabic_name": "ناصب سقالات",
        "code": "711901"
    },
    {
        "english_name": "Asphalt and artificial components roofing worker",
        "arabic_name": "عامل تسقيف أسفلت ومكونات اصطناعية",
        "code": "712101"
    },
    {
        "english_name": "Roofing Sheet metal worker",
        "arabic_name": "عامل تسقيف ألواح معدنية",
        "code": "712102"
    },
    {
        "english_name": "Wood and clay roofing worker",
        "arabic_name": "عامل تسقيف اخشاب وطين",
        "code": "712103"
    },
    {
        "english_name": "Roof slate and tiles worker",
        "arabic_name": "عامل تسقيف اردواز وقرميد",
        "code": "712104"
    },
    {
        "english_name": "Rugs, carpets, and plastic flooring installer",
        "arabic_name": "مركّب سجاد وموكيت وأرضيات لدائنية",
        "code": "712201"
    },
    {
        "english_name": "Tile setter",
        "arabic_name": "مبلط",
        "code": "712202"
    },
    {
        "english_name": "Hardwood floor installer",
        "arabic_name": "عامل تركيب أرضية خشبية",
        "code": "712203"
    },
    {
        "english_name": "Mosaic installer",
        "arabic_name": "مركب الفسيفساء",
        "code": "712204"
    },
    {
        "english_name": "Gypsum worker",
        "arabic_name": "مجبس",
        "code": "712301"
    },
    {
        "english_name": "Pipe and boiler insulation worker",
        "arabic_name": "عامل عزل أنابيب ومراجل",
        "code": "712401"
    },
    {
        "english_name": "Acoustic Insulation Technician",
        "arabic_name": "عامل عزل صوتي",
        "code": "712402"
    },
    {
        "english_name": "Thermal Insulation Technician",
        "arabic_name": "عامل عزل حراري",
        "code": "712403"
    },
    {
        "english_name": "Waterproofing Technician",
        "arabic_name": "عامل عزل مائي",
        "code": "712404"
    },
    {
        "english_name": "A glazier",
        "arabic_name": "مركب زجاج",
        "code": "712501"
    },
    {
        "english_name": "Plumber",
        "arabic_name": "سباك",
        "code": "712601"
    },
    {
        "english_name": "Pipe installer",
        "arabic_name": "مركب أنابيب",
        "code": "712602"
    },
    {
        "english_name": "Compressor mechanic",
        "arabic_name": "ميكانيكي ضاغطة",
        "code": "712701"
    },
    {
        "english_name": "HVAC Mechanic",
        "arabic_name": "ميكانيكي تدفئة وتهوية وتكييف",
        "code": "712702"
    },
    {
        "english_name": "Refrigeration mechanic",
        "arabic_name": "ميكانيكي برادات",
        "code": "712703"
    },
    {
        "english_name": "Painter",
        "arabic_name": "دهّان",
        "code": "713101"
    },
    {
        "english_name": "Wallpaper Hanger",
        "arabic_name": "مركب ورق جدران",
        "code": "713102"
    },
    {
        "english_name": "Spray Painter",
        "arabic_name": "عامل طلاء بالرش",
        "code": "713201"
    },
    {
        "english_name": "Varnish painter",
        "arabic_name": "عامل طلاء بالورنيش",
        "code": "713202"
    },
    {
        "english_name": "Vehicle Spray Painter",
        "arabic_name": "عامل طلاء مركبات",
        "code": "713203"
    },
    {
        "english_name": "Products Spray Painter",
        "arabic_name": "عامل طلاء مصنوعات",
        "code": "713204"
    },
    {
        "english_name": "Building Facade Cleaner",
        "arabic_name": "منظف واجهات مباني",
        "code": "713301"
    },
    {
        "english_name": "Tile cleaning worker",
        "arabic_name": "جلاء بلاط",
        "code": "713302"
    },
    {
        "english_name": "Roofs Cleaner",
        "arabic_name": "عامل تنظيف أسطح مباني",
        "code": "713303"
    },
    {
        "english_name": "Chimney cleaner",
        "arabic_name": "عامل تنظيف مداخن",
        "code": "713304"
    },
    {
        "english_name": "Metal casting worker",
        "arabic_name": "سابك معادن",
        "code": "721101"
    },
    {
        "english_name": "Metal Mold Maker",
        "arabic_name": "صانع قوالب معدنية",
        "code": "721102"
    },
    {
        "english_name": "Welder",
        "arabic_name": "لحّام",
        "code": "721201"
    },
    {
        "english_name": "Underwater welder",
        "arabic_name": "لحّام تحت الماء",
        "code": "721202"
    },
    {
        "english_name": "Flame cutting machine operator",
        "arabic_name": "قاطع لهب",
        "code": "721203"
    },
    {
        "english_name": "Boilers Blacksmith",
        "arabic_name": "حدّاد مراجل",
        "code": "721301"
    },
    {
        "english_name": "Copper Blacksmith",
        "arabic_name": "حداّد نحاس",
        "code": "721302"
    },
    {
        "english_name": "Tinsmith",
        "arabic_name": "حداّد صفيح",
        "code": "721303"
    },
    {
        "english_name": "Auto plumber",
        "arabic_name": "سمكري مركبات",
        "code": "721304"
    },
    {
        "english_name": "Riveting worker",
        "arabic_name": "عامل برشمة",
        "code": "721401"
    },
    {
        "english_name": "Metal Construction Assembler",
        "arabic_name": "محضّر ومركّب هياكل معدنية",
        "code": "721402"
    },
    {
        "english_name": "Wire Robe Technician",
        "arabic_name": "عامل وصل الحبال والسلاسل المعدنية بالجدل",
        "code": "721501"
    },
    {
        "english_name": "Cranes Worker",
        "arabic_name": "عامل رافعات",
        "code": "721502"
    },
    {
        "english_name": "Blacksmith",
        "arabic_name": "حدّاد",
        "code": "722101"
    },
    {
        "english_name": "Press-Tool Setter",
        "arabic_name": "حدّاد مكبس تشكيلي",
        "code": "722102"
    },
    {
        "english_name": "Power Hammer Operator",
        "arabic_name": "حدّاد مطرقة آلية",
        "code": "722103"
    },
    {
        "english_name": "Bladesmith",
        "arabic_name": "حدّاد نصال",
        "code": "722104"
    },
    {
        "english_name": "Weapons Manufacturer",
        "arabic_name": "صانع أسلحة",
        "code": "722201"
    },
    {
        "english_name": "Locksmith",
        "arabic_name": "صانع أقفال",
        "code": "722202"
    },
    {
        "english_name": "Kit & Tools Maker",
        "arabic_name": "صانع أدوات و عدة",
        "code": "722203"
    },
    {
        "english_name": "Lathe Operator",
        "arabic_name": "مشغل مخرطة",
        "code": "722301"
    },
    {
        "english_name": "Metal Finisher",
        "arabic_name": "مُشطِّب معادن",
        "code": "722401"
    },
    {
        "english_name": "Metal Tools Stropper & Grinder",
        "arabic_name": "سنّان ومجلّخ أدوات معدنية",
        "code": "722402"
    },
    {
        "english_name": "Auto Mechanic",
        "arabic_name": "ميكانيكي سيارات",
        "code": "723101"
    },
    {
        "english_name": "Bus Mechanic",
        "arabic_name": "ميكانيكي حافلات",
        "code": "723102"
    },
    {
        "english_name": "Motorcycle Mechanic",
        "arabic_name": "ميكانيكي دراجة نارية",
        "code": "723103"
    },
    {
        "english_name": "Tire Installer",
        "arabic_name": "مُركِّب إطارات",
        "code": "723104"
    },
    {
        "english_name": "Auto Glazier",
        "arabic_name": "مُصلِح زجاج مركبات",
        "code": "723105"
    },
    {
        "english_name": "Vehicle’s Oiler & Greaser",
        "arabic_name": "مشحم ومزيت مركبات",
        "code": "723106"
    },
    {
        "english_name": "Aircraft Technician",
        "arabic_name": "ميكانيكي طائرات",
        "code": "723201"
    },
    {
        "english_name": "Airframe Technician",
        "arabic_name": "ميكانيكي إصلاح هيكل الطائرة",
        "code": "723202"
    },
    {
        "english_name": "Aircraft Engine Technician",
        "arabic_name": "ميكانيكي محرك طائرة",
        "code": "723203"
    },
    {
        "english_name": "Agricultural Equipment Technician",
        "arabic_name": "ميكانيكي معدات زراعية",
        "code": "723301"
    },
    {
        "english_name": "Heavy Equipment Technician",
        "arabic_name": "ميكانيكي معدات ثقيلة",
        "code": "723302"
    },
    {
        "english_name": "Light Equipment Technician",
        "arabic_name": "ميكانيكي معدات خفيفة",
        "code": "723303"
    },
    {
        "english_name": "Train Mechanic",
        "arabic_name": "ميكانيكي قطارات",
        "code": "723304"
    },
    {
        "english_name": "Mining Equipment Technician",
        "arabic_name": "ميكانيكي معدات تعدين",
        "code": "723305"
    },
    {
        "english_name": "Drilling Rig Mechanic",
        "arabic_name": "ميكانيكي منصة حفر",
        "code": "723306"
    },
    {
        "english_name": "Ship Mechanic",
        "arabic_name": "ميكانيكي سفن",
        "code": "723307"
    },
    {
        "english_name": "NMVs Repairer",
        "arabic_name": "مصلح عربات من غير محرك",
        "code": "723401"
    },
    {
        "english_name": "Wheelchair Repairer",
        "arabic_name": "مصلح كرسي متحرك",
        "code": "723402"
    },
    {
        "english_name": "Bicycle Repairer",
        "arabic_name": "مصلح دراجة هوائية",
        "code": "723403"
    },
    {
        "english_name": "Measuring Instruments Repairer",
        "arabic_name": "مُصلّح أجهزة قياس",
        "code": "731101"
    },
    {
        "english_name": "Precision Instruments Repairer",
        "arabic_name": "مُصلّح أجهزة دقيقة",
        "code": "731102"
    },
    {
        "english_name": "Watch Repairer",
        "arabic_name": "مُصلّح ساعات",
        "code": "731103"
    },
    {
        "english_name": "Optical Instruments Repairer",
        "arabic_name": "مُصلّح أجهزة بصرية",
        "code": "731104"
    },
    {
        "english_name": "Piano Tuner",
        "arabic_name": "مدوزن بيانو",
        "code": "731201"
    },
    {
        "english_name": "Inflatable Musical Instruments Maker & Repairer",
        "arabic_name": "صانع ومصلح آلات موسيقية نفخية",
        "code": "731202"
    },
    {
        "english_name": "String Musical Instruments Maker & Repairer",
        "arabic_name": "صانع ومصلح آلات موسيقية وترية",
        "code": "731203"
    },
    {
        "english_name": "Percussion Musical Instruments Maker & Repairer",
        "arabic_name": "صانع ومصلح آلات موسيقية نقر",
        "code": "731204"
    },
    {
        "english_name": "Goldsmith",
        "arabic_name": "صائغ",
        "code": "731301"
    },
    {
        "english_name": "Gemstone Installer",
        "arabic_name": "مركب أحجار كريمة",
        "code": "731302"
    },
    {
        "english_name": "Precious Metals Decoration & Enamelling Jeweler",
        "arabic_name": "صائغ زخرفة معادن ثمينة وطلاء بالمينا",
        "code": "731303"
    },
    {
        "english_name": "Pottery & Ceramics Maker",
        "arabic_name": "صانع الفخار والسيراميك",
        "code": "731401"
    },
    {
        "english_name": "Pottery & Ceramics Molds Maker",
        "arabic_name": "صانع قوالب الفخار والسيراميك",
        "code": "731402"
    },
    {
        "english_name": "Glass Finisher",
        "arabic_name": "مشطب زجاج",
        "code": "731501"
    },
    {
        "english_name": "Glassmaker",
        "arabic_name": "زجّاج",
        "code": "731502"
    },
    {
        "english_name": "Decorative Painter",
        "arabic_name": "دهّان زخرفي",
        "code": "731601"
    },
    {
        "english_name": "Chiseler",
        "arabic_name": "نقّاش",
        "code": "731602"
    },
    {
        "english_name": "Calligrapher",
        "arabic_name": "خطاط",
        "code": "731603"
    },
    {
        "english_name": "Glass Painter",
        "arabic_name": "ملون زجاج",
        "code": "731604"
    },
    {
        "english_name": "Weaving Canes, Bamboo, Fronds & Wicker Artificer",
        "arabic_name": "حِرَفي نسج قصب وخيزران وسعف و خوص",
        "code": "731701"
    },
    {
        "english_name": "Wooden Products Crafter",
        "arabic_name": "حِرَفي منتجات خشبية",
        "code": "731702"
    },
    {
        "english_name": "knitter",
        "arabic_name": "حائك",
        "code": "731801"
    },
    {
        "english_name": "Spinner",
        "arabic_name": "غزّال",
        "code": "731802"
    },
    {
        "english_name": "Carpet Manual Weaver",
        "arabic_name": "ناسج سجاد يدوي",
        "code": "731803"
    },
    {
        "english_name": "Leather Craft Worker",
        "arabic_name": "عامل حرف جلدية",
        "code": "731804"
    },
    {
        "english_name": "Fishing Net Weaver",
        "arabic_name": "حائك شبك صيد",
        "code": "731805"
    },
    {
        "english_name": "Textile Handicraft Worker",
        "arabic_name": "نسّاج",
        "code": "731806"
    },
    {
        "english_name": "Document Restorer",
        "arabic_name": "مرمم وثائق",
        "code": "731901"
    },
    {
        "english_name": "Wax Maker",
        "arabic_name": "صانع شمع",
        "code": "731902"
    },
    {
        "english_name": "Print Processing Technician",
        "arabic_name": "فني تجهيز طباعة",
        "code": "732101"
    },
    {
        "english_name": "Silkscreen Printing Maker",
        "arabic_name": "صانع شاشة طباعة حريرية",
        "code": "732102"
    },
    {
        "english_name": "Offset Printing Plates Maker",
        "arabic_name": "صانع لوحات طباعة اوفست",
        "code": "732103"
    },
    {
        "english_name": "Printing Machine Operator",
        "arabic_name": "مُشغِّل آلة طباعة",
        "code": "732201"
    },
    {
        "english_name": "Print Binding & Finishing Worker",
        "arabic_name": "عامل تشطيبات طباعة وتجليد",
        "code": "732301"
    },
    {
        "english_name": "Book Sewer",
        "arabic_name": "خياط كتب",
        "code": "732302"
    },
    {
        "english_name": "Building Electrician",
        "arabic_name": "كهربائي مباني",
        "code": "741101"
    },
    {
        "english_name": "Auto Electrician",
        "arabic_name": "كهربائي سيارات",
        "code": "741201"
    },
    {
        "english_name": "Electrical Mechanic",
        "arabic_name": "ميكانيكي كهرباء",
        "code": "741202"
    },
    {
        "english_name": "Elevator Mechanic",
        "arabic_name": "ميكانيكي مصاعد",
        "code": "741203"
    },
    {
        "english_name": "Train Electrician",
        "arabic_name": "كهربائي قطارات",
        "code": "741204"
    },
    {
        "english_name": "Ship Electrician",
        "arabic_name": "كهربائي سفن",
        "code": "741205"
    },
    {
        "english_name": "Drilling Rig Electrician",
        "arabic_name": "كهربائي منصة حفر",
        "code": "741206"
    },
    {
        "english_name": "Electrical Devices Maintenance Technician",
        "arabic_name": "عامل صيانة أجهزة كهربائية",
        "code": "741207"
    },
    {
        "english_name": "Aircraft Electrician",
        "arabic_name": "كهربائي طائرات",
        "code": "741208"
    },
    {
        "english_name": "Power Cable Connector",
        "arabic_name": "موصل كابلات كهربائية",
        "code": "741301"
    },
    {
        "english_name": "Power Lines Operator",
        "arabic_name": "عامل خطوط طاقة كهربائية",
        "code": "741302"
    },
    {
        "english_name": "Aircraft Electronics Technician",
        "arabic_name": "إلكتروني طائرات",
        "code": "742101"
    },
    {
        "english_name": "Electronic Equipment Technician",
        "arabic_name": "ميكانيكي معدات إلكترونية",
        "code": "742102"
    },
    {
        "english_name": "ICT Services Technician",
        "arabic_name": "عامل خدمات الاتصالات وتقنية المعلومات",
        "code": "742201"
    },
    {
        "english_name": "ICT Lines Installer",
        "arabic_name": "عامل تركيب خطوط الاتصالات وتقنية المعلومات",
        "code": "742202"
    },
    {
        "english_name": "Butcher",
        "arabic_name": "جزّار",
        "code": "751101"
    },
    {
        "english_name": "Fishmonger",
        "arabic_name": "سمّاك",
        "code": "751102"
    },
    {
        "english_name": "Slaughterer",
        "arabic_name": "قصّاب",
        "code": "751103"
    },
    {
        "english_name": "Baker",
        "arabic_name": "خبّاز",
        "code": "751201"
    },
    {
        "english_name": "Confectioner",
        "arabic_name": "خبّاز حلويات",
        "code": "751202"
    },
    {
        "english_name": "Sweets Maker",
        "arabic_name": "صانع حلويات",
        "code": "751203"
    },
    {
        "english_name": "Dairy Products Makers",
        "arabic_name": "صانع منتجات ألبان",
        "code": "751301"
    },
    {
        "english_name": "Ghee Manufacturer",
        "arabic_name": "صانع سمن",
        "code": "751302"
    },
    {
        "english_name": "Cottage Cheese Manufacture",
        "arabic_name": "صانع أقط",
        "code": "751303"
    },
    {
        "english_name": "Fruits & Vegetables Preserver",
        "arabic_name": "عامل حفظ فواكه وخضروات",
        "code": "751401"
    },
    {
        "english_name": "Food & Beverages Taster",
        "arabic_name": "متذوق أطعمة ومشروبات",
        "code": "751501"
    },
    {
        "english_name": "Food & Beverages Classifier",
        "arabic_name": "مصنف أطعمة ومشروبات",
        "code": "751502"
    },
    {
        "english_name": "Tobacco Products Manufacturer",
        "arabic_name": "مصنع منتجات تبغ",
        "code": "751601"
    },
    {
        "english_name": "Tobacco Products Preparer",
        "arabic_name": "معد منتجات تبغ",
        "code": "751602"
    },
    {
        "english_name": "Wood Processor",
        "arabic_name": "مُعالج أخشاب",
        "code": "752101"
    },
    {
        "english_name": "Carvings & Mother of Pearl Carpenter",
        "arabic_name": "نجار حفر وصدفيات",
        "code": "752201"
    },
    {
        "english_name": "Furniture Carpenter",
        "arabic_name": "نجار اثاث",
        "code": "752202"
    },
    {
        "english_name": "Woodworking Machines and Tools Operator & Preparer",
        "arabic_name": "مُعدّ ومشغّل أدوات وآلات النجارة",
        "code": "752301"
    },
    {
        "english_name": "Women Clothing Tailor",
        "arabic_name": "خيّاط ملابس نسائية",
        "code": "753101"
    },
    {
        "english_name": "Men Clothing Tailor",
        "arabic_name": "خيّاط ملابس رجالية",
        "code": "753102"
    },
    {
        "english_name": "Fur Clothing & Bisht Tailor",
        "arabic_name": "خيّاط ملابس فرائية ومشالح",
        "code": "753103"
    },
    {
        "english_name": "Agal Tailor",
        "arabic_name": "مفصل عقال",
        "code": "753104"
    },
    {
        "english_name": "Military Tailor",
        "arabic_name": "خيّاط ملابس عسكرية",
        "code": "753105"
    },
    {
        "english_name": "Garment Patternmaker",
        "arabic_name": "صانع نماذج ملابس",
        "code": "753201"
    },
    {
        "english_name": "Tailor",
        "arabic_name": "خياط",
        "code": "753301"
    },
    {
        "english_name": "Embroidery Worker",
        "arabic_name": "عامل تطريز",
        "code": "753302"
    },
    {
        "english_name": "Upholsterer",
        "arabic_name": "مُنجِّد",
        "code": "753401"
    },
    {
        "english_name": "Mattress Maker",
        "arabic_name": "صانع مراتب",
        "code": "753402"
    },
    {
        "english_name": "Tanner",
        "arabic_name": "دباغ جلود",
        "code": "753501"
    },
    {
        "english_name": "Genuine Leather Processor",
        "arabic_name": "معالج جلود طبيعية",
        "code": "753502"
    },
    {
        "english_name": "Shoemaker",
        "arabic_name": "اسكافي",
        "code": "753601"
    },
    {
        "english_name": "Leather Goods Manufacturer",
        "arabic_name": "صانع منتجات جلدية",
        "code": "753602"
    },
    {
        "english_name": "Oyster Diver",
        "arabic_name": "غواص محار",
        "code": "754101"
    },
    {
        "english_name": "Diver",
        "arabic_name": "غوّاص",
        "code": "754102"
    },
    {
        "english_name": "Marine Construction Diver",
        "arabic_name": "غواص إنشاءات بحرية",
        "code": "754103"
    },
    {
        "english_name": "Explosive Worker",
        "arabic_name": "عامل متفجرات",
        "code": "754201"
    },
    {
        "english_name": "Quality Controller",
        "arabic_name": "مراقب الجودة",
        "code": "754301"
    },
    {
        "english_name": "Product Examiner & Evaluator",
        "arabic_name": "فاحص ومقيّم منتجات",
        "code": "754302"
    },
    {
        "english_name": "Pest Control Worker",
        "arabic_name": "عامل مكافحة آفات",
        "code": "754401"
    },
    {
        "english_name": "Fake Flower Manufacturer",
        "arabic_name": "صانع زهور اصطناعية",
        "code": "754901"
    },
    {
        "english_name": "Flowers Coordinator",
        "arabic_name": "منسق زهور",
        "code": "754902"
    },
    {
        "english_name": "Incense & Perfume Maker",
        "arabic_name": "صانع بخور وعطور",
        "code": "754903"
    },
    {
        "english_name": "Mining worker",
        "arabic_name": "عامل تعدين",
        "code": "811101"
    },
    {
        "english_name": "Stonecutter",
        "arabic_name": "حجار",
        "code": "811102"
    },
    {
        "english_name": "Worker of installing mine ceilings",
        "arabic_name": "عامل تثبيت أسقف مناجم",
        "code": "811103"
    },
    {
        "english_name": "Mine machines operator",
        "arabic_name": "مشغل آلات مناجم",
        "code": "811104"
    },
    {
        "english_name": "Crusher operator",
        "arabic_name": "مشغل كسارة",
        "code": "811201"
    },
    {
        "english_name": "Ore Mineral Mill Operator",
        "arabic_name": "مشغل مطحنة معادن خام",
        "code": "811202"
    },
    {
        "english_name": "Screening machine operator",
        "arabic_name": "مشغل آلة غربلة",
        "code": "811203"
    },
    {
        "english_name": "Stone processing machine operator",
        "arabic_name": "مشغل آلة معالجة أحجار",
        "code": "811204"
    },
    {
        "english_name": "Offshore drilling rig",
        "arabic_name": "حفار آبار بحرية",
        "code": "811301"
    },
    {
        "english_name": "Oil and gas production machinery operator",
        "arabic_name": "مشغل آلات إنتاج نفط وغاز",
        "code": "811302"
    },
    {
        "english_name": "Drilling ground wells",
        "arabic_name": "حفار آبار برية",
        "code": "811303"
    },
    {
        "english_name": "Operator of oil and gas well drilling machines",
        "arabic_name": "مشغل آلات حفر آبار نفط وغاز",
        "code": "811304"
    },
    {
        "english_name": "Operator of Water Well Drilling Machines",
        "arabic_name": "مشغل آلات حفر آبار مياه",
        "code": "811305"
    },
    {
        "english_name": "Worker of lining oil and gas wells",
        "arabic_name": "عامل تبطين آبار نفط وغاز",
        "code": "811306"
    },
    {
        "english_name": "Worker of Lining Water Well",
        "arabic_name": "عامل تبطين آبار مياه",
        "code": "811307"
    },
    {
        "english_name": "Operator of well pump",
        "arabic_name": "مشغل مضخة آبار",
        "code": "811308"
    },
    {
        "english_name": "Cement production machine operator",
        "arabic_name": "مشغل آلة إنتاج إسمنت",
        "code": "811401"
    },
    {
        "english_name": "Concrete production machine operator",
        "arabic_name": "مشغل آلة إنتاج الخرسانة",
        "code": "811402"
    },
    {
        "english_name": "Operator of stone and metal products production machine",
        "arabic_name": "مشغل آلة إنتاج منتجات حجرية ومعدنية",
        "code": "811403"
    },
    {
        "english_name": "Cement brick production machine operator",
        "arabic_name": "مشغل آلة إنتاج طوب إسمنتي",
        "code": "811404"
    },
    {
        "english_name": "Operator of ore smelter",
        "arabic_name": "مشغل مصهر معادن خام",
        "code": "812101"
    },
    {
        "english_name": "Metal Casting Machine Operator",
        "arabic_name": "مشغل آلة صب المعادن",
        "code": "812102"
    },
    {
        "english_name": "Metal rolling machine operator",
        "arabic_name": "مشغل آلة درفلة معادن",
        "code": "812103"
    },
    {
        "english_name": "Metal Extrusion Machine Operator",
        "arabic_name": "مشغل آلة بثق معادن",
        "code": "812104"
    },
    {
        "english_name": "Operator of metal heat treatment machine",
        "arabic_name": "مشغل آلة معالجة حرارية للمعادن",
        "code": "812105"
    },
    {
        "english_name": "Operator of metal forging machine",
        "arabic_name": "مشغل آلة طرق معادن",
        "code": "812106"
    },
    {
        "english_name": "Metal Finishing Machine Operator",
        "arabic_name": "مشغل آلة تشطيب معادن",
        "code": "812201"
    },
    {
        "english_name": "Metal Coating Machine Operator",
        "arabic_name": "مشغل آلة طلاء معادن",
        "code": "812202"
    },
    {
        "english_name": "Metal Galvanizing Machine Operator",
        "arabic_name": "مشغل آلة جلفنة المعادن",
        "code": "812203"
    },
    {
        "english_name": "Metal polishing machines operator",
        "arabic_name": "مشغل معدات صقل وتلميع معادن",
        "code": "812204"
    },
    {
        "english_name": "Metal boring Machine Operator",
        "arabic_name": "مشغل آلة تجويف معادن",
        "code": "812205"
    },
    {
        "english_name": "Chemical Industries Machine Operator",
        "arabic_name": "مشغل آلة صناعات كيميائية",
        "code": "813101"
    },
    {
        "english_name": "Pharmaceutical production machine operator",
        "arabic_name": "مشغل آلة إنتاج مستحضرات صيدلانية",
        "code": "813102"
    },
    {
        "english_name": "Cosmetics production machine operator",
        "arabic_name": "مشغل آلة إنتاج مستحضرات تجميل",
        "code": "813103"
    },
    {
        "english_name": "Paints production machine operator",
        "arabic_name": "مشغل آلة إنتاج دهانات",
        "code": "813104"
    },
    {
        "english_name": "Fertilizer production machine operator",
        "arabic_name": "مشغل آلة إنتاج أسمدة",
        "code": "813105"
    },
    {
        "english_name": "Chemical Mixing Machine Operator",
        "arabic_name": "مشغل آلة خلط مواد كيميائية",
        "code": "813106"
    },
    {
        "english_name": "Chemical processing machine operator",
        "arabic_name": "مشغل آلة معالجة كيميائية",
        "code": "813107"
    },
    {
        "english_name": "Chemical Filling Machine Operator",
        "arabic_name": "مشغل آلة تعبئة منتجات كيميائية",
        "code": "813108"
    },
    {
        "english_name": "Explosives production machine operator",
        "arabic_name": "مشغل آلة إنتاج متفجرات",
        "code": "813109"
    },
    {
        "english_name": "Photocopier production machine operator",
        "arabic_name": "مشغل آلة إنتاج مستلزمات تصوير فوتوغرافي",
        "code": "813201"
    },
    {
        "english_name": "Rubber processing machine operator",
        "arabic_name": "مشغل آلة تصنيع مطاط",
        "code": "814101"
    },
    {
        "english_name": "Rubber production machine operator",
        "arabic_name": "مشغل آلة تصنيع منتجات مطاطية",
        "code": "814102"
    },
    {
        "english_name": "Rubber lamination machine operator",
        "arabic_name": "مشغل آلة تصفيح المطاط",
        "code": "814103"
    },
    {
        "english_name": "Rubber Forming Machine Operator",
        "arabic_name": "مشغل آلة تشكيل مطاط",
        "code": "814104"
    },
    {
        "english_name": "Rubber tire manufacturing machine operator",
        "arabic_name": "مشغل آلة تصنيع إطارات مطاطية",
        "code": "814105"
    },
    {
        "english_name": "Used tires reconstruction worker",
        "arabic_name": "عامل إعادة بناء إطارات مستعملة",
        "code": "814106"
    },
    {
        "english_name": "Plastic manufacturing machines operator",
        "arabic_name": "مشغل آلات تصنيع مواد بلاستيكية",
        "code": "814201"
    },
    {
        "english_name": "Plastic products machine operator",
        "arabic_name": "مشغل آلات تصنيع منتجات بلاستيكية",
        "code": "814202"
    },
    {
        "english_name": "Plastic Mixing Machine Operator",
        "arabic_name": "مشغل آلات خلط مواد بلاستيكية",
        "code": "814203"
    },
    {
        "english_name": "Plastic Forming Machine Operator",
        "arabic_name": "مشغل آلات تشكيل بلاستيك",
        "code": "814204"
    },
    {
        "english_name": "Plastic Finishing Machine Operator",
        "arabic_name": "مشغل آلة تشطيب منتجات بلاستيكية",
        "code": "814205"
    },
    {
        "english_name": "Paper manufacturing machine operator",
        "arabic_name": "مشغل آلة تصنيع منتجات ورقية",
        "code": "814301"
    },
    {
        "english_name": "Paper pulp machine operator",
        "arabic_name": "مشغل آلة عجينة ورق",
        "code": "814302"
    },
    {
        "english_name": "Paper Drying Machine Operator",
        "arabic_name": "مشغل آلة تجفيف ورق",
        "code": "814303"
    },
    {
        "english_name": "Cardboard manufacturing machine operator",
        "arabic_name": "مشغل آلة تصنيع ورق مقوى",
        "code": "814304"
    },
    {
        "english_name": "Paper lining machine operator",
        "arabic_name": "مشغل آلة تبطين ورق",
        "code": "814305"
    },
    {
        "english_name": "Paper cutting machine operator",
        "arabic_name": "مشغل آلة قص ورق",
        "code": "814306"
    },
    {
        "english_name": "Paper Forming Machine Operator",
        "arabic_name": "مشغل آلة تشكيل ورق",
        "code": "814307"
    },
    {
        "english_name": "Yarn spinning Machine Operator",
        "arabic_name": "مشغل آلة غزل خيوط",
        "code": "815101"
    },
    {
        "english_name": "Thread Twisting Machine Operator",
        "arabic_name": "مشغل آلة جدل خيوط",
        "code": "815102"
    },
    {
        "english_name": "Synthetic Fibers processing Machine Operator",
        "arabic_name": "مشغل آلة تصنيع ألياف اصطناعية",
        "code": "815103"
    },
    {
        "english_name": "Cotton ginning machine operator",
        "arabic_name": "مشغل آلة حلج قطن",
        "code": "815104"
    },
    {
        "english_name": "Fiber processing machine operator",
        "arabic_name": "مشغل آلة تجهيز ألياف",
        "code": "815105"
    },
    {
        "english_name": "Operator of winding machine",
        "arabic_name": "مشغل آلة لف شلائل",
        "code": "815106"
    },
    {
        "english_name": "Textile Machine Operator",
        "arabic_name": "مشغل آلة نسيج",
        "code": "815201"
    },
    {
        "english_name": "Automatic loom operator",
        "arabic_name": "مشغل نول آلي",
        "code": "815202"
    },
    {
        "english_name": "Programmable knitting machine operator",
        "arabic_name": "مشغل آلة حياكة مبرمجة",
        "code": "815203"
    },
    {
        "english_name": "Knitting Machine Operator",
        "arabic_name": "مشغل آلة حياكة",
        "code": "815204"
    },
    {
        "english_name": "Sewing machine operator",
        "arabic_name": "مشغل آلة خياطة",
        "code": "815301"
    },
    {
        "english_name": "Rolling machine operator",
        "arabic_name": "مشغل آلة السرفلة",
        "code": "815302"
    },
    {
        "english_name": "Operator of Button Mounting Machine",
        "arabic_name": "مشغل آلة تركيب أزرار",
        "code": "815303"
    },
    {
        "english_name": "Buttonhole machine operator",
        "arabic_name": "مشغل آلة عراوي",
        "code": "815304"
    },
    {
        "english_name": "Iron press machine operator",
        "arabic_name": "مشغل آلة مكبس كي",
        "code": "815305"
    },
    {
        "english_name": "Cloth Cutting Machine Operator",
        "arabic_name": "مشغل آلة قص قماش",
        "code": "815306"
    },
    {
        "english_name": "Embroidery machine operator",
        "arabic_name": "مشغل آلة تطريز",
        "code": "815307"
    },
    {
        "english_name": "Textile bleaching machine operator",
        "arabic_name": "مشغل آلة تبييض منسوجات",
        "code": "815401"
    },
    {
        "english_name": "Textile dyeing machine operator",
        "arabic_name": "مشغل آلة صباغة المنسوجات",
        "code": "815402"
    },
    {
        "english_name": "Operator of thread finishing machine",
        "arabic_name": "مشغل آلة تشطيب خيوط",
        "code": "815403"
    },
    {
        "english_name": "Thread processing machine operator",
        "arabic_name": "مشغل آلة معالجة خيوط غزل",
        "code": "815404"
    },
    {
        "english_name": "Thread dyeing machine operator",
        "arabic_name": "مشغل آلة صباغة خيوط",
        "code": "815405"
    },
    {
        "english_name": "Fabric rolling machine operator",
        "arabic_name": "مشغل آلة لف الأقمشة",
        "code": "815406"
    },
    {
        "english_name": "Fabric washing machine operator",
        "arabic_name": "مشغل آلة غسيل الأقمشة",
        "code": "815407"
    },
    {
        "english_name": "Fabric Aging Machine Operator",
        "arabic_name": "مشغل آلة تعتيق أقمشة",
        "code": "815408"
    },
    {
        "english_name": "Operator of textile drying ovens",
        "arabic_name": "مشغل أفران تجفيف منسوجات",
        "code": "815409"
    },
    {
        "english_name": "Textile finishing machine operator",
        "arabic_name": "مشغل آلة تشطيب منسوجات",
        "code": "815410"
    },
    {
        "english_name": "Leather and fur processing machine operator",
        "arabic_name": "مشغل آلة معالجة جلود وفرو",
        "code": "815501"
    },
    {
        "english_name": "Leather cleaning tub operator",
        "arabic_name": "مشغل أحواض تنظيف الجلود",
        "code": "815502"
    },
    {
        "english_name": "Leather shaving machine operator",
        "arabic_name": "مشغل آلة حلاقة الجلود",
        "code": "815503"
    },
    {
        "english_name": "Operator of Hide and flesh cleaning machine",
        "arabic_name": "مشغل آلة تنظيف الأدمة والتلحيم",
        "code": "815504"
    },
    {
        "english_name": "Leather pulling and tightening machine operator",
        "arabic_name": "مشغل آلة سحب وشد الجلود",
        "code": "815505"
    },
    {
        "english_name": "Leather tanning machine operator",
        "arabic_name": "مشغل آلة دباغة جلود",
        "code": "815506"
    },
    {
        "english_name": "Leather and fur dyeing machine operator",
        "arabic_name": "مشغل آلة صباغة جلود وفرو",
        "code": "815507"
    },
    {
        "english_name": "Leather drying ovens operator",
        "arabic_name": "مشغل أفران تجفيف جلود",
        "code": "815508"
    },
    {
        "english_name": "Leather polishing machine operator",
        "arabic_name": "مشغل آلة صقل جلود",
        "code": "815509"
    },
    {
        "english_name": "Shoe production machine operator",
        "arabic_name": "مشغل آلة إنتاج أحذية",
        "code": "815601"
    },
    {
        "english_name": "Shoes finishing machine operator",
        "arabic_name": "مشغل آلة تشطيب أحذية",
        "code": "815602"
    },
    {
        "english_name": "Operator of bags production machine",
        "arabic_name": "مشغل آلة إنتاج حقائب",
        "code": "815603"
    },
    {
        "english_name": "Bag finishing machine operator",
        "arabic_name": "مشغل آلة تشطيب حقائب",
        "code": "815604"
    },
    {
        "english_name": "Laundry and linen machine operator",
        "arabic_name": "مشغل آلة غسيل ملابس وبياضات",
        "code": "815701"
    },
    {
        "english_name": "Carpet and moquette washing machine operator",
        "arabic_name": "مشغل آلة غسيل سجاد وموكيت",
        "code": "815702"
    },
    {
        "english_name": "Ironing machine operator",
        "arabic_name": "مشغل آلة كي",
        "code": "815703"
    },
    {
        "english_name": "Textile cutting model drawing machine operator",
        "arabic_name": "مشغل آلة رسم نماذج قص المنسوجات",
        "code": "815901"
    },
    {
        "english_name": "Plaiting machine operator",
        "arabic_name": "مشغل آلة صنع ضفائر",
        "code": "815902"
    },
    {
        "english_name": "Tents Making Machine Operator",
        "arabic_name": "مشغل آلة صنع خيام",
        "code": "815903"
    },
    {
        "english_name": "Balloon making Machine Operator",
        "arabic_name": "مشغل آلة صنع مناطيد",
        "code": "815904"
    },
    {
        "english_name": "Bakery and Confectionery Production Machine Operator",
        "arabic_name": "مشغل آلة إنتاج مخابز وحلويات",
        "code": "816001"
    },
    {
        "english_name": "Dairy machine operator",
        "arabic_name": "مشغل آلة منتجات ألبان",
        "code": "816002"
    },
    {
        "english_name": "Food drying machine operator",
        "arabic_name": "مشغل آلة تجفيف أطعمة",
        "code": "816003"
    },
    {
        "english_name": "Fruits and Vegetables processing Machine Operator",
        "arabic_name": "مشغل آلة منتجات فواكه وخضراوات",
        "code": "816004"
    },
    {
        "english_name": "Plant Leaf Products Machine Operator",
        "arabic_name": "مشغل آلة منتجات أوراق نباتات",
        "code": "816005"
    },
    {
        "english_name": "Grain Products Machine Operator",
        "arabic_name": "مشغل آلة منتجات حبوب",
        "code": "816006"
    },
    {
        "english_name": "Edible Oil Products Machine Operator",
        "arabic_name": "مشغل آلة منتجات زيوت طعام",
        "code": "816007"
    },
    {
        "english_name": "Meat processing machine operator",
        "arabic_name": "مشغل آلة تصنيع لحوم",
        "code": "816008"
    },
    {
        "english_name": "Fish and crustacean processing machine operator",
        "arabic_name": "مشغل آلة تصنيع أسماك وقشريات",
        "code": "816009"
    },
    {
        "english_name": "Grain mill machine operator",
        "arabic_name": "مشغل آلة مطحن حبوب",
        "code": "816010"
    },
    {
        "english_name": "Sugar production machine operator",
        "arabic_name": "مشغل آلة إنتاج سكر",
        "code": "816011"
    },
    {
        "english_name": "Food sterilization machine operator",
        "arabic_name": "مشغل آلة تعقيم مواد غذائية",
        "code": "816012"
    },
    {
        "english_name": "Date seed sorting machine operator",
        "arabic_name": "مشغل آلة فرز النواة",
        "code": "816013"
    },
    {
        "english_name": "Dates fumigator operator",
        "arabic_name": "مشغل مبخرة تمور",
        "code": "816014"
    },
    {
        "english_name": "Dates Production Machine Operator",
        "arabic_name": "مشغل آلة انتاج تمور",
        "code": "816015"
    },
    {
        "english_name": "Cellulose processing machine operator",
        "arabic_name": "مشغل آلة معالجة سليلوز",
        "code": "817101"
    },
    {
        "english_name": "Pulp Processing Machine Operator",
        "arabic_name": "مشغل آلة معالجة لب",
        "code": "817102"
    },
    {
        "english_name": "Paper processing machine operator",
        "arabic_name": "مشغل آلة تصنيع ورق",
        "code": "817103"
    },
    {
        "english_name": "Paper finishing machine operator",
        "arabic_name": "مشغل آلة تشطيب ورق",
        "code": "817104"
    },
    {
        "english_name": "Woodworking Saw Operator",
        "arabic_name": "مشغل منشار خشب",
        "code": "817201"
    },
    {
        "english_name": "Wood Surfacing Machine Operator",
        "arabic_name": "مشغل آلة تسوية أسطح أخشاب",
        "code": "817202"
    },
    {
        "english_name": "Wood Shaping Machine Operator",
        "arabic_name": "مشغل آلة تشكيل خشب",
        "code": "817203"
    },
    {
        "english_name": "Wood Dovetail Machine Operator",
        "arabic_name": "مشغل آلة تزرير خشب",
        "code": "817204"
    },
    {
        "english_name": "Wood Press Machine Operator",
        "arabic_name": "مشغل مكبس أخشاب",
        "code": "817205"
    },
    {
        "english_name": "Wood Product Manufacturing Machine Operator",
        "arabic_name": "مشغل آلة تصنيع منتجات خشبية",
        "code": "817206"
    },
    {
        "english_name": "Wood Drying Oven Operator",
        "arabic_name": "مشغل فرن تجفيف الخشب",
        "code": "817207"
    },
    {
        "english_name": "Veneer Making Machine Operator",
        "arabic_name": "مشغل آلة تصنيع قشرة",
        "code": "817208"
    },
    {
        "english_name": "Wood Cutting Machine Operator",
        "arabic_name": "مشغل آلة قطع خشب",
        "code": "817209"
    },
    {
        "english_name": "Ceramic Processing Machine Operator",
        "arabic_name": "مشغل آلة تصنيع سيراميك",
        "code": "818101"
    },
    {
        "english_name": "Glass Making Machine Operator",
        "arabic_name": "مشغل آلة تصنيع زجاج",
        "code": "818102"
    },
    {
        "english_name": "Glass Melting Oven Operator",
        "arabic_name": "مشغل فرن صهر زجاج",
        "code": "818103"
    },
    {
        "english_name": "Glass Panel Shaping Machine Operator",
        "arabic_name": "مشغل آلة تشكيل ألواح الزجاج",
        "code": "818104"
    },
    {
        "english_name": "Glass Blowing Machine Operator",
        "arabic_name": "مشغل آلة نفخ زجاج",
        "code": "818105"
    },
    {
        "english_name": "Glass Finishing Machine Operator",
        "arabic_name": "مشغل آلة تشطيب زجاج",
        "code": "818106"
    },
    {
        "english_name": "Stone and Marble Lathe Operator",
        "arabic_name": "مشغل مخرطة حجر ورخام",
        "code": "818107"
    },
    {
        "english_name": "Marble Finishing Machine Operator",
        "arabic_name": "مشغل آلة تشطيب رخام",
        "code": "818108"
    },
    {
        "english_name": "Tile Making Machine Operator",
        "arabic_name": "مشغل آلة تصنيع بلاط",
        "code": "818109"
    },
    {
        "english_name": "Tile and Brick Drier Operator",
        "arabic_name": "مشغل فرن طوب وبلاط",
        "code": "818110"
    },
    {
        "english_name": "Tile Finishing Machine Operator",
        "arabic_name": "مشغل آلة تشطيب بلاط",
        "code": "818111"
    },
    {
        "english_name": "Steam Boilers Operator",
        "arabic_name": "مشغل مراجل بخار",
        "code": "818201"
    },
    {
        "english_name": "Water Boiler Operator",
        "arabic_name": "مشغل غلايات مياه",
        "code": "818202"
    },
    {
        "english_name": "Turbine Operator",
        "arabic_name": "مشغل توربين",
        "code": "818203"
    },
    {
        "english_name": "Steam Generator Operator",
        "arabic_name": "مشغل مولد بخار",
        "code": "818204"
    },
    {
        "english_name": "Label Printing Machine Operator",
        "arabic_name": "مشغل آلات طباعة العلامات",
        "code": "818301"
    },
    {
        "english_name": "Filling Machine Operator",
        "arabic_name": "مشغل آلة تعبئة",
        "code": "818302"
    },
    {
        "english_name": "Packing Machine Operator",
        "arabic_name": "مشغل آلة تغليف",
        "code": "818303"
    },
    {
        "english_name": "Card Labelling Machine Operator",
        "arabic_name": "مشغل آلة لصق بطاقات إنتاج",
        "code": "818304"
    },
    {
        "english_name": "Silicon Wafer Production Machine Operator",
        "arabic_name": "مشغل آلة إنتاج رقائق السيليكون",
        "code": "818901"
    },
    {
        "english_name": "Rope Splicing Machine Operator",
        "arabic_name": "مشغل آلة جدل حبال",
        "code": "818902"
    },
    {
        "english_name": "Water Pump Operator",
        "arabic_name": "مشغل مضخة مياه",
        "code": "818903"
    },
    {
        "english_name": "Cooling Devices Assembler",
        "arabic_name": "مُجمع أجهزة تبريد",
        "code": "821101"
    },
    {
        "english_name": "Engine Assembler",
        "arabic_name": "مُجمع محركات",
        "code": "821102"
    },
    {
        "english_name": "Transmissions Assembler",
        "arabic_name": "مُجمع ناقلات حركة",
        "code": "821103"
    },
    {
        "english_name": "Vehicle Assembler",
        "arabic_name": "مُجمع سيارات",
        "code": "821104"
    },
    {
        "english_name": "Aircraft Assembler",
        "arabic_name": "مُجمع طائرات",
        "code": "821105"
    },
    {
        "english_name": "Mechanical Equipment Assembler",
        "arabic_name": "مُجمع معدات ميكانيكية",
        "code": "821106"
    },
    {
        "english_name": "Electrical Equipment Assembler",
        "arabic_name": "مُجمع معدات كهربائية",
        "code": "821201"
    },
    {
        "english_name": "Electronic Mechanical Equipment Assembler",
        "arabic_name": "مُجمع معدات إلكترونية",
        "code": "821202"
    },
    {
        "english_name": "Electrical Transformer Assembler",
        "arabic_name": "مُجمع محولات كهربائية",
        "code": "821203"
    },
    {
        "english_name": "Power Distribution Boards Assembler",
        "arabic_name": "مُجمع لوحات توزيع كهربائية",
        "code": "821204"
    },
    {
        "english_name": "Electric Devices Assembler",
        "arabic_name": "مُجمع أجهزة كهربائية",
        "code": "821205"
    },
    {
        "english_name": "Medical Devices Assembler",
        "arabic_name": "مُجمع أجهزة طبية",
        "code": "821206"
    },
    {
        "english_name": "Electronic Devices Assembler",
        "arabic_name": "مُجمع أجهزة إلكترونية",
        "code": "821207"
    },
    {
        "english_name": "Electronic Exchange Assembler",
        "arabic_name": "مُجمع مقاسم إلكترونية",
        "code": "821208"
    },
    {
        "english_name": "Furniture Assembling Worker",
        "arabic_name": "عامل تجميع أثاث",
        "code": "821901"
    },
    {
        "english_name": "Plastic and Metal products assembling worker",
        "arabic_name": "عامل تجميع منتجات بلاستيكية ومعدنية",
        "code": "821902"
    },
    {
        "english_name": "Cardboard Assembly Worker",
        "arabic_name": "عامل تجميع ورق مقوى",
        "code": "821903"
    },
    {
        "english_name": "Textile Product Assembly Worker",
        "arabic_name": "عامل تجميع منتجات نسيجية",
        "code": "821904"
    },
    {
        "english_name": "Fiber Assembling and Bundling Worker",
        "arabic_name": "عامل تجميع وحزم الألياف",
        "code": "821905"
    },
    {
        "english_name": "Rubber Products Assembly Worker",
        "arabic_name": "عامل تجميع منتجات المطاط",
        "code": "821906"
    },
    {
        "english_name": "Bicycle Assembly Worker",
        "arabic_name": "عامل تجميع دراجات هوائية",
        "code": "821907"
    },
    {
        "english_name": "Tractor Driver",
        "arabic_name": "سائق قاطرة",
        "code": "831101"
    },
    {
        "english_name": "Train Driver",
        "arabic_name": "سائق قطار",
        "code": "831102"
    },
    {
        "english_name": "Metro Driver",
        "arabic_name": "سائق مترو",
        "code": "831103"
    },
    {
        "english_name": "Train Brakes’ Operator",
        "arabic_name": "مشغل فرامل قطارات",
        "code": "831201"
    },
    {
        "english_name": "Trains converter’s Operator",
        "arabic_name": "مشغل تحويلة قطارات",
        "code": "831202"
    },
    {
        "english_name": "Operator of Railway Signals",
        "arabic_name": "مشغل إشارات سكك حديدية",
        "code": "831203"
    },
    {
        "english_name": "Train & Vehicle Yard Observer",
        "arabic_name": "ملاحظ ساحة قطارات وعربات",
        "code": "831204"
    },
    {
        "english_name": "Motorcycle Driver",
        "arabic_name": "سائق دراجة نارية",
        "code": "832101"
    },
    {
        "english_name": "Car Driver",
        "arabic_name": "سائق سيارة",
        "code": "832201"
    },
    {
        "english_name": "Private Car Driver",
        "arabic_name": "سائق سيارة خاص",
        "code": "832202"
    },
    {
        "english_name": "Taxi Driver",
        "arabic_name": "سائق سيارة أجرة",
        "code": "832203"
    },
    {
        "english_name": "Ambulance Driver",
        "arabic_name": "سائق سيارة إسعاف",
        "code": "832204"
    },
    {
        "english_name": "Minitruck driver",
        "arabic_name": "سائق شاحنة صغيرة",
        "code": "832205"
    },
    {
        "english_name": "Valet Parking Attendant",
        "arabic_name": "سائق خدمة صف سيارات",
        "code": "832206"
    },
    {
        "english_name": "Bus Driver",
        "arabic_name": "سائق حافلة",
        "code": "833101"
    },
    {
        "english_name": "Tram Driver",
        "arabic_name": "سائق ترام",
        "code": "833102"
    },
    {
        "english_name": "Truck Driver",
        "arabic_name": "سائق شاحنة ثقيلة",
        "code": "833201"
    },
    {
        "english_name": "Tank Truck",
        "arabic_name": "سائق شاحنة خزان سوائل وغاز",
        "code": "833202"
    },
    {
        "english_name": "Trailer Truck Driver",
        "arabic_name": "سائق شاحنة بمقطورة",
        "code": "833203"
    },
    {
        "english_name": "Concrete Mixer Driver",
        "arabic_name": "سائق خلاط إسمنت",
        "code": "833204"
    },
    {
        "english_name": "Garbage Truck Driver",
        "arabic_name": "سائق شاحنة رفع قمامة",
        "code": "833205"
    },
    {
        "english_name": "Agricultural Tractor Driver",
        "arabic_name": "سائق جرار زراعي",
        "code": "834101"
    },
    {
        "english_name": "Agricultural Equipment Operator",
        "arabic_name": "مشغل معدات زراعية",
        "code": "834102"
    },
    {
        "english_name": "Mobile pest spraying equipment operator",
        "arabic_name": "مشغل معدات رش آفات متنقلة",
        "code": "834103"
    },
    {
        "english_name": "Mobile irrigation equipment operator",
        "arabic_name": "مشغل معدات ري متنقلة",
        "code": "834104"
    },
    {
        "english_name": "Loader Operator",
        "arabic_name": "مشغل مجرفة تحميل",
        "code": "834201"
    },
    {
        "english_name": "Road Roller Operator",
        "arabic_name": "مشغل مدحلة طرق",
        "code": "834202"
    },
    {
        "english_name": "Bulldozer Operator",
        "arabic_name": "مشغل جرافة",
        "code": "834203"
    },
    {
        "english_name": "Excavator Operator",
        "arabic_name": "مشغل حفارة",
        "code": "834204"
    },
    {
        "english_name": "Asphalt Paver Operator",
        "arabic_name": "مشغل معدات سفلتة",
        "code": "834205"
    },
    {
        "english_name": "Grader Operator",
        "arabic_name": "مشغل آلة تمهيد أراضي",
        "code": "834206"
    },
    {
        "english_name": "Heavy truck Driver",
        "arabic_name": "سائق معدات ثقيلة",
        "code": "834207"
    },
    {
        "english_name": "Crane Operator",
        "arabic_name": "مشغل رافعة",
        "code": "834301"
    },
    {
        "english_name": "Winch Operator",
        "arabic_name": "مشغل ونش",
        "code": "834302"
    },
    {
        "english_name": "Cranes Coordinator",
        "arabic_name": "منسق حركة رافعات",
        "code": "834303"
    },
    {
        "english_name": "Forklift driver",
        "arabic_name": "سائق رافعة شوكية",
        "code": "834401"
    },
    {
        "english_name": "Tower Crane Operator",
        "arabic_name": "مشغل رافعة برجية",
        "code": "834402"
    },
    {
        "english_name": "Helmsman",
        "arabic_name": "قائد الدّفة",
        "code": "835001"
    },
    {
        "english_name": "Sailor",
        "arabic_name": "بحّار",
        "code": "835002"
    },
    {
        "english_name": "Ship equipment operator",
        "arabic_name": "مشغل معدات سفن",
        "code": "835003"
    },
    {
        "english_name": "Dock worker",
        "arabic_name": "عامل فك وربط سفن",
        "code": "835004"
    },
    {
        "english_name": "Housekeeper",
        "arabic_name": "عامل تنظيف وخدمة منزلي",
        "code": "911101"
    },
    {
        "english_name": "Mosque Caretaker",
        "arabic_name": "خادم مسجد",
        "code": "911201"
    },
    {
        "english_name": "Hotel housekeeper",
        "arabic_name": "عامل تدبير فندقي",
        "code": "911202"
    },
    {
        "english_name": "Offices and facilities Cleaning worker",
        "arabic_name": "عامل تنظيف مكاتب ومنشآت",
        "code": "911203"
    },
    {
        "english_name": "Hospital Cleaner",
        "arabic_name": "عامل تنظيف مستشفيات",
        "code": "911204"
    },
    {
        "english_name": "Laundryman",
        "arabic_name": "عامل غسيل ملابس",
        "code": "912101"
    },
    {
        "english_name": "Ironer",
        "arabic_name": "عامل كي",
        "code": "912102"
    },
    {
        "english_name": "Carpet and rug Cleaner",
        "arabic_name": "عامل غسيل سجاد وموكيت",
        "code": "912103"
    },
    {
        "english_name": "Curtain washer",
        "arabic_name": "عامل غسيل ستائر",
        "code": "912104"
    },
    {
        "english_name": "Vehicle Cleaner",
        "arabic_name": "عامل تنظيف مركبات",
        "code": "912201"
    },
    {
        "english_name": "Aircraft cleaning worker",
        "arabic_name": "عامل تنظيف طائرات",
        "code": "912202"
    },
    {
        "english_name": "Ship cleaning worker",
        "arabic_name": "عامل تنظيف سفن",
        "code": "912203"
    },
    {
        "english_name": "Train cleaning worker",
        "arabic_name": "عامل تنظيف قطارات",
        "code": "912204"
    },
    {
        "english_name": "Windows cleaner",
        "arabic_name": "مُنظّف نوافذ",
        "code": "912301"
    },
    {
        "english_name": "Swimming pool cleaner",
        "arabic_name": "مُنظّف مسابح",
        "code": "912901"
    },
    {
        "english_name": "Water Tanks Cleaner",
        "arabic_name": "عامل تنظيف خزانات مياه",
        "code": "912902"
    },
    {
        "english_name": "Sanitation cleaner",
        "arabic_name": "عامل صرف صحي",
        "code": "912903"
    },
    {
        "english_name": "Agricultural driver",
        "arabic_name": "سائق زراعي",
        "code": "832207"
    },
    {
        "english_name": "Farm worker",
        "arabic_name": "عامل زراعي",
        "code": "921101"
    },
    {
        "english_name": "Farm worker for pest treatment",
        "arabic_name": "عامل زراعي معالجة آفات",
        "code": "921102"
    },
    {
        "english_name": "Animal farm worker",
        "arabic_name": "عامل مزرعة حيوانات",
        "code": "921201"
    },
    {
        "english_name": "Poultry and birds farm worker",
        "arabic_name": "عامل مزرعة دواجن وطيور",
        "code": "921202"
    },
    {
        "english_name": "Stable hand",
        "arabic_name": "عامل اسطبل",
        "code": "921203"
    },
    {
        "english_name": "Hatching worker",
        "arabic_name": "عامل تفريخ بيض",
        "code": "921204"
    },
    {
        "english_name": "Farm worker for agricultural and animal production",
        "arabic_name": "عامل مزرعة انتاج زراعي وحيواني",
        "code": "921301"
    },
    {
        "english_name": "Landscaping worker",
        "arabic_name": "عامل مسطحات خضراء",
        "code": "921401"
    },
    {
        "english_name": "Nursery worker",
        "arabic_name": "عامل مشتل",
        "code": "921402"
    },
    {
        "english_name": "Forest worker",
        "arabic_name": "عامل غابات",
        "code": "921501"
    },
    {
        "english_name": "Pastures worker",
        "arabic_name": "عامل مراعي",
        "code": "921502"
    },
    {
        "english_name": "Forest fire fighting worker",
        "arabic_name": "عامل مكافحة حرائق غابات",
        "code": "921503"
    },
    {
        "english_name": "Fish farm worker",
        "arabic_name": "عامل مزرعة سمكية",
        "code": "921601"
    },
    {
        "english_name": "Fish farm worker",
        "arabic_name": "عامل صيد أسماك",
        "code": "921602"
    },
    {
        "english_name": "Miner",
        "arabic_name": "عامل منجم",
        "code": "931101"
    },
    {
        "english_name": "Quarry worker",
        "arabic_name": "عامل محجر",
        "code": "931102"
    },
    {
        "english_name": "Construction worker",
        "arabic_name": "عامل إنشاءات",
        "code": "931201"
    },
    {
        "english_name": "Road maintenance worker",
        "arabic_name": "عامل صيانة الطرق",
        "code": "931202"
    },
    {
        "english_name": "Asphalting worker",
        "arabic_name": "عامل سفلتة",
        "code": "931203"
    },
    {
        "english_name": "Soil samples collector",
        "arabic_name": "جامع عينات تربة",
        "code": "931204"
    },
    {
        "english_name": "Torrents measurement officer",
        "arabic_name": "قائس سيول",
        "code": "931205"
    },
    {
        "english_name": "Drilling worker",
        "arabic_name": "عامل حفر",
        "code": "931206"
    },
    {
        "english_name": "Graves worker",
        "arabic_name": "عامل مقبرة",
        "code": "931207"
    },
    {
        "english_name": "Constructing worker",
        "arabic_name": "عامل بناء",
        "code": "931301"
    },
    {
        "english_name": "concrete mix worker",
        "arabic_name": "عامل خلطة خرسانية",
        "code": "931302"
    },
    {
        "english_name": "Demolishing worker",
        "arabic_name": "عامل هدم",
        "code": "931303"
    },
    {
        "english_name": "Packaging worker",
        "arabic_name": "عامل تعبئة وتغليف",
        "code": "932101"
    },
    {
        "english_name": "Labeling worker",
        "arabic_name": "عامل وضع ملصقات",
        "code": "932102"
    },
    {
        "english_name": "Manufacturing officer",
        "arabic_name": "عامل تصنيع",
        "code": "932901"
    },
    {
        "english_name": "Product sorting worker",
        "arabic_name": "عامل فرز منتجات",
        "code": "932902"
    },
    {
        "english_name": "Workshop worker",
        "arabic_name": "عامل ورشة",
        "code": "932903"
    },
    {
        "english_name": "Wheelbarrow worker",
        "arabic_name": "عامل جر عربة يدوية",
        "code": "933101"
    },
    {
        "english_name": "Transport car worker",
        "arabic_name": "عامل دراجة نقل",
        "code": "933102"
    },
    {
        "english_name": "Animal cart Worker",
        "arabic_name": "عامل قيادة عربة جر بالحيوان",
        "code": "933201"
    },
    {
        "english_name": "Load and unload worker",
        "arabic_name": "عامل تحميل وتنزيل",
        "code": "933301"
    },
    {
        "english_name": "Packing the shelves worker",
        "arabic_name": "عامل تعبئة رفوف",
        "code": "933401"
    },
    {
        "english_name": "Warehouse worker",
        "arabic_name": "عامل مخزن",
        "code": "933402"
    },
    {
        "english_name": "Fast food maker",
        "arabic_name": "معد وجبات سريعة",
        "code": "941101"
    },
    {
        "english_name": "Meal maker for a food cart",
        "arabic_name": "معد وجبات عربة طعام",
        "code": "941102"
    },
    {
        "english_name": "Worker to clean kitchen appliances",
        "arabic_name": "عامل تنظيف أدوات مطبخ",
        "code": "941201"
    },
    {
        "english_name": "Kitchen worker",
        "arabic_name": "عامل مطبخ",
        "code": "941202"
    },
    {
        "english_name": "Shoe polisher",
        "arabic_name": "ملمع أحذية",
        "code": "951001"
    },
    {
        "english_name": "Distributor of leaflets",
        "arabic_name": "موزع منشورات",
        "code": "951002"
    },
    {
        "english_name": "Mobile Vehicle Washing worker",
        "arabic_name": "عامل غسيل مركبات متنقل",
        "code": "951003"
    },
    {
        "english_name": "Peddler",
        "arabic_name": "بائع متجول",
        "code": "952001"
    },
    {
        "english_name": "Newspaper Seller",
        "arabic_name": "بائع صحف",
        "code": "952002"
    },
    {
        "english_name": "Waste collector",
        "arabic_name": "جامع نفايات",
        "code": "961101"
    },
    {
        "english_name": "Waste sorter",
        "arabic_name": "فارز نفايات",
        "code": "961201"
    },
    {
        "english_name": "Street clean worker",
        "arabic_name": "عامل نظافة شوارع",
        "code": "961301"
    },
    {
        "english_name": "garden clean worker",
        "arabic_name": "عامل نظافة حدائق",
        "code": "961302"
    },
    {
        "english_name": "messenger",
        "arabic_name": "مراسل",
        "code": "962101"
    },
    {
        "english_name": "Carrier",
        "arabic_name": "حمال",
        "code": "962102"
    },
    {
        "english_name": "Unique occupation worker",
        "arabic_name": "عامل مهن فريدة",
        "code": "962201"
    },
    {
        "english_name": "Meter reader",
        "arabic_name": "قارئ عدادات",
        "code": "962301"
    },
    {
        "english_name": "Machine collector of self-sale",
        "arabic_name": "محصل آلات بيع ذاتي",
        "code": "962302"
    },
    {
        "english_name": "Bill distributer",
        "arabic_name": "موزع فواتير",
        "code": "962303"
    },
    {
        "english_name": "Firewood collector",
        "arabic_name": "جامع حطب",
        "code": "962401"
    },
    {
        "english_name": "Water collector",
        "arabic_name": "جامع مياه",
        "code": "962402"
    },
    {
        "english_name": "Car parking worker",
        "arabic_name": "عامل مواقف سيارات",
        "code": "962901"
    },
    {
        "english_name": "Ticket Checker",
        "arabic_name": "مدقق تذاكر",
        "code": "962902"
    }
];


for $job in $jobs {
    create saudi_job content {
        english_name: $job.english_name,
        arabic_name: $job.arabic_name,
        code: $job.code
    };
};



let $airlines = [
    {
        "airline_key": "AQ",
        "airline_name": "9 Air"
    },
    {
        "airline_key": "9G",
        "airline_name": "9G Rail Ltd"
    },
    {
        "airline_key": "A1",
        "airline_name": "A.P.G. Distribution System"
    },
    {
        "airline_key": "Y6",
        "airline_name": "Ab Aviation"
    },
    {
        "airline_key": "1B",
        "airline_name": "Abacus"
    },
    {
        "airline_key": "GB",
        "airline_name": "ABX Air"
    },
    {
        "airline_key": "9B",
        "airline_name": "Accesrail"
    },
    {
        "airline_key": "6U",
        "airline_name": "ACG Air Cargo Germany"
    },
    {
        "airline_key": "9T",
        "airline_name": "Act Havayollari"
    },
    {
        "airline_key": "JP",
        "airline_name": "Adria Airways"
    },
    {
        "airline_key": "AN",
        "airline_name": "Advanced Air"
    },
    {
        "airline_key": "A3",
        "airline_name": "Aegean Airlines"
    },
    {
        "airline_key": "EI",
        "airline_name": "Aer Lingus"
    },
    {
        "airline_key": "A7",
        "airline_name": "Aereo Calafia"
    },
    {
        "airline_key": "M0",
        "airline_name": "Aero Mongolia"
    },
    {
        "airline_key": "P5",
        "airline_name": "Aero Republica"
    },
    {
        "airline_key": "H4",
        "airline_name": "Aero4M"
    },
    {
        "airline_key": "7L",
        "airline_name": "Aerocaribbean"
    },
    {
        "airline_key": "DW",
        "airline_name": "Aero-Charter"
    },
    {
        "airline_key": "5G",
        "airline_name": "Aerocuahonte"
    },
    {
        "airline_key": "VB",
        "airline_name": "Aeroenlaces Nacionales"
    },
    {
        "airline_key": "SU",
        "airline_name": "Aeroflot"
    },
    {
        "airline_key": "5P",
        "airline_name": "Aerolinea Principal Chile"
    },
    {
        "airline_key": "AR",
        "airline_name": "Aerolineas Argentinas"
    },
    {
        "airline_key": "N3",
        "airline_name": "Aerolineas Mas"
    },
    {
        "airline_key": "S0",
        "airline_name": "Aerolineas Sosa S.A. De C.V."
    },
    {
        "airline_key": "A8",
        "airline_name": "Aerolink Uganda Limited"
    },
    {
        "airline_key": "5D",
        "airline_name": "Aerolitoral"
    },
    {
        "airline_key": "VW",
        "airline_name": "Aeromar"
    },
    {
        "airline_key": "AM",
        "airline_name": "Aeromexico"
    },
    {
        "airline_key": "V5",
        "airline_name": "Aerovias DAP"
    },
    {
        "airline_key": "L8",
        "airline_name": "Afric Aviation"
    },
    {
        "airline_key": "FK",
        "airline_name": "Africa West Cargo (Ghd)"
    },
    {
        "airline_key": "AW",
        "airline_name": "Africa World Airlines"
    },
    {
        "airline_key": "XU",
        "airline_name": "African Express Airways"
    },
    {
        "airline_key": "J7",
        "airline_name": "Afrijet Business Service"
    },
    {
        "airline_key": "8U",
        "airline_name": "Afriqiyah Airways"
    },
    {
        "airline_key": "ZI",
        "airline_name": "Aigle Azur"
    },
    {
        "airline_key": "ZB",
        "airline_name": "Air Albania"
    },
    {
        "airline_key": "AH",
        "airline_name": "Air Algerie"
    },
    {
        "airline_key": "6I",
        "airline_name": "Air Alsie"
    },
    {
        "airline_key": "QN",
        "airline_name": "Air Amenia"
    },
    {
        "airline_key": "3S",
        "airline_name": "Air Antilles Express"
    },
    {
        "airline_key": "G9",
        "airline_name": "Air Arabia"
    },
    {
        "airline_key": "E5",
        "airline_name": "Air Arabia Egypt"
    },
    {
        "airline_key": "9P",
        "airline_name": "Air Arabia Jordan"
    },
    {
        "airline_key": "3O",
        "airline_name": "Air Arabia Maroc"
    },
    {
        "airline_key": "UU",
        "airline_name": "Air Austral"
    },
    {
        "airline_key": "BT",
        "airline_name": "Air Baltic"
    },
    {
        "airline_key": "KF",
        "airline_name": "Air Belgium"
    },
    {
        "airline_key": "AB",
        "airline_name": "Air Berlin"
    },
    {
        "airline_key": "BP",
        "airline_name": "Air Botswana"
    },
    {
        "airline_key": "RU",
        "airline_name": "Air Bridge Cargo"
    },
    {
        "airline_key": "2J",
        "airline_name": "Air Burkina"
    },
    {
        "airline_key": "BX",
        "airline_name": "Air Busan (CSH)"
    },
    {
        "airline_key": "SM",
        "airline_name": "Air Cairo"
    },
    {
        "airline_key": "TY",
        "airline_name": "Air Caledonie"
    },
    {
        "airline_key": "AC",
        "airline_name": "Air Canada"
    },
    {
        "airline_key": "RV",
        "airline_name": "Air Canada Rouge"
    },
    {
        "airline_key": "TX",
        "airline_name": "Air Caraibes"
    },
    {
        "airline_key": "2S",
        "airline_name": "Air Carnival"
    },
    {
        "airline_key": "3C",
        "airline_name": "Air Chathams"
    },
    {
        "airline_key": "CA",
        "airline_name": "Air China"
    },
    {
        "airline_key": "GG",
        "airline_name": "Air Comores International"
    },
    {
        "airline_key": "XK",
        "airline_name": "Air Corsica"
    },
    {
        "airline_key": "LB",
        "airline_name": "Air Costa"
    },
    {
        "airline_key": "HF",
        "airline_name": "Air Cote D Ivoire"
    },
    {
        "airline_key": "YN",
        "airline_name": "Air Creebec"
    },
    {
        "airline_key": "EN",
        "airline_name": "Air Dolomiti"
    },
    {
        "airline_key": "UX",
        "airline_name": "Air Europa"
    },
    {
        "airline_key": "X4",
        "airline_name": "Air Excursions"
    },
    {
        "airline_key": "ED",
        "airline_name": "Air Explore"
    },
    {
        "airline_key": "F4",
        "airline_name": "Air Flamenco"
    },
    {
        "airline_key": "AF",
        "airline_name": "Air France"
    },
    {
        "airline_key": "OG",
        "airline_name": "Air Freight Nz"
    },
    {
        "airline_key": "GN",
        "airline_name": "Air Gabon"
    },
    {
        "airline_key": "DA",
        "airline_name": "Air Georgia"
    },
    {
        "airline_key": "ZX",
        "airline_name": "Air Georgian"
    },
    {
        "airline_key": "GL",
        "airline_name": "Air Greenland"
    },
    {
        "airline_key": "GT",
        "airline_name": "Air Guilin"
    },
    {
        "airline_key": "NY",
        "airline_name": "Air Iceland Connect"
    },
    {
        "airline_key": "KJ",
        "airline_name": "Air Incheon"
    },
    {
        "airline_key": "IX",
        "airline_name": "Air India Charters Limited"
    },
    {
        "airline_key": "AI",
        "airline_name": "Air India Limited"
    },
    {
        "airline_key": "I6",
        "airline_name": "Air Indus"
    },
    {
        "airline_key": "3H",
        "airline_name": "Air Inuit"
    },
    {
        "airline_key": "IG",
        "airline_name": "Air Italy"
    },
    {
        "airline_key": "NQ",
        "airline_name": "Air Japan Company Ltd"
    },
    {
        "airline_key": "7A",
        "airline_name": "Air Jet"
    },
    {
        "airline_key": "AO",
        "airline_name": "Air Juan Aviation"
    },
    {
        "airline_key": "K7",
        "airline_name": "Air KBZ"
    },
    {
        "airline_key": "IK",
        "airline_name": "Air Kiribati"
    },
    {
        "airline_key": "JS",
        "airline_name": "Air Koryo"
    },
    {
        "airline_key": "AL",
        "airline_name": "Air Leisure"
    },
    {
        "airline_key": "NX",
        "airline_name": "Air Macau"
    },
    {
        "airline_key": "MD",
        "airline_name": "Air Madagascar"
    },
    {
        "airline_key": "KM",
        "airline_name": "Air Malta"
    },
    {
        "airline_key": "ZM",
        "airline_name": "Air Manas"
    },
    {
        "airline_key": "6T",
        "airline_name": "Air Mandalay"
    },
    {
        "airline_key": "MK",
        "airline_name": "Air Mauritius"
    },
    {
        "airline_key": "MV",
        "airline_name": "Air Mediterranean"
    },
    {
        "airline_key": "ML",
        "airline_name": "Air Mediterranee"
    },
    {
        "airline_key": "M1",
        "airline_name": "Air Memphis"
    },
    {
        "airline_key": "6M",
        "airline_name": "Air Minas Linhas Aereas"
    },
    {
        "airline_key": "MC",
        "airline_name": "Air Mobility Command"
    },
    {
        "airline_key": "9U",
        "airline_name": "Air Moldova"
    },
    {
        "airline_key": "SW",
        "airline_name": "Air Namibia"
    },
    {
        "airline_key": "NZ",
        "airline_name": "Air New Zealand"
    },
    {
        "airline_key": "PX",
        "airline_name": "Air Niugini"
    },
    {
        "airline_key": "4N",
        "airline_name": "Air North"
    },
    {
        "airline_key": "YW",
        "airline_name": "Air Nostrum"
    },
    {
        "airline_key": "7P",
        "airline_name": "Air Panama"
    },
    {
        "airline_key": "P4",
        "airline_name": "Air Peace Limited"
    },
    {
        "airline_key": "GZ",
        "airline_name": "Air Rarotonga"
    },
    {
        "airline_key": "PJ",
        "airline_name": "Air Saint Pierre"
    },
    {
        "airline_key": "HC",
        "airline_name": "Air Senegal"
    },
    {
        "airline_key": "RS",
        "airline_name": "Air Seoul"
    },
    {
        "airline_key": "JU",
        "airline_name": "Air Serbia"
    },
    {
        "airline_key": "L4",
        "airline_name": "Air Service Li\u00e8ge"
    },
    {
        "airline_key": "HM",
        "airline_name": "Air Seychelles"
    },
    {
        "airline_key": "4D",
        "airline_name": "Air Sinai"
    },
    {
        "airline_key": "VT",
        "airline_name": "Air Tahiti"
    },
    {
        "airline_key": "TN",
        "airline_name": "Air Tahiti Nui"
    },
    {
        "airline_key": "TC",
        "airline_name": "Air Tanzania"
    },
    {
        "airline_key": "6C",
        "airline_name": "Air Timor"
    },
    {
        "airline_key": "8T",
        "airline_name": "Air Tindi Ltd"
    },
    {
        "airline_key": "TS",
        "airline_name": "Air Transat"
    },
    {
        "airline_key": "U7",
        "airline_name": "Air Uganda"
    },
    {
        "airline_key": "3N",
        "airline_name": "Air Urga"
    },
    {
        "airline_key": "VK",
        "airline_name": "Air Vall\u00e9e"
    },
    {
        "airline_key": "NF",
        "airline_name": "Air Vanuatu"
    },
    {
        "airline_key": "ZW",
        "airline_name": "Air Wisconsin"
    },
    {
        "airline_key": "UM",
        "airline_name": "Air Zimbabwe"
    },
    {
        "airline_key": "I5",
        "airline_name": "AirAsia India"
    },
    {
        "airline_key": "DJ",
        "airline_name": "Airasia Japan"
    },
    {
        "airline_key": "AK",
        "airline_name": "AirAsia Sdn Bhd"
    },
    {
        "airline_key": "D7",
        "airline_name": "AirAsiaX Sdn Bhd"
    },
    {
        "airline_key": "SB",
        "airline_name": "Aircalin"
    },
    {
        "airline_key": "RM",
        "airline_name": "Aircompany Armenia"
    },
    {
        "airline_key": "0K",
        "airline_name": "Aircompany Kokshetau"
    },
    {
        "airline_key": "SZ",
        "airline_name": "Aircompany Somon Air"
    },
    {
        "airline_key": "HD",
        "airline_name": "AirDo"
    },
    {
        "airline_key": "QP",
        "airline_name": "Airkenya Aviation"
    },
    {
        "airline_key": "P2",
        "airline_name": "Airkenya Express"
    },
    {
        "airline_key": "ZZ",
        "airline_name": "Airline Service"
    },
    {
        "airline_key": "X6",
        "airline_name": "Airlines Reporting Corp."
    },
    {
        "airline_key": "X8",
        "airline_name": "Airmax"
    },
    {
        "airline_key": "TL",
        "airline_name": "Airnorth"
    },
    {
        "airline_key": "RN",
        "airline_name": "Airpohang"
    },
    {
        "airline_key": "FL",
        "airline_name": "AirTran Airways"
    },
    {
        "airline_key": "J6",
        "airline_name": "Airways International"
    },
    {
        "airline_key": "IS",
        "airline_name": "AIS Airlines B.V."
    },
    {
        "airline_key": "6L",
        "airline_name": "Aklak Air"
    },
    {
        "airline_key": "NG",
        "airline_name": "Al Naser Wings"
    },
    {
        "airline_key": "9A",
        "airline_name": "Aladia Airlines"
    },
    {
        "airline_key": "YZ",
        "airline_name": "Alas Uruguay"
    },
    {
        "airline_key": "AS",
        "airline_name": "Alaska Airlines"
    },
    {
        "airline_key": "J5",
        "airline_name": "Alaska Seaplane Service"
    },
    {
        "airline_key": "AP",
        "airline_name": "Alba Star"
    },
    {
        "airline_key": "2B",
        "airline_name": "Albawings"
    },
    {
        "airline_key": "CT",
        "airline_name": "Alitalia City Liner Spa"
    },
    {
        "airline_key": "NH",
        "airline_name": "All Nippon Airways"
    },
    {
        "airline_key": "G4",
        "airline_name": "Allegiant Air"
    },
    {
        "airline_key": "9I",
        "airline_name": "Alliance Air"
    },
    {
        "airline_key": "QQ",
        "airline_name": "Alliance Airlines"
    },
    {
        "airline_key": "C4",
        "airline_name": "Alma de Mexico"
    },
    {
        "airline_key": "UJ",
        "airline_name": "Almasria Universal Airlines"
    },
    {
        "airline_key": "NR",
        "airline_name": "Al-Naser Airlines"
    },
    {
        "airline_key": "7U",
        "airline_name": "Alpha Air Transport"
    },
    {
        "airline_key": "C9",
        "airline_name": "Alphaland Aviation"
    },
    {
        "airline_key": "K4",
        "airline_name": "Als Ltd."
    },
    {
        "airline_key": "5I",
        "airline_name": "Alsa Grupo Slu"
    },
    {
        "airline_key": "1A",
        "airline_name": "Amadeus"
    },
    {
        "airline_key": "0Z",
        "airline_name": "Amadeus 0Z"
    },
    {
        "airline_key": "0Q",
        "airline_name": "Amadeus Airline 0Q"
    },
    {
        "airline_key": "0X",
        "airline_name": "Amadeus Airline 0X"
    },
    {
        "airline_key": "0Y",
        "airline_name": "Amadeus Airline 0Y"
    },
    {
        "airline_key": "8X",
        "airline_name": "Amadeus Eight"
    },
    {
        "airline_key": "2Y",
        "airline_name": "Amadeus PDF 2Y"
    },
    {
        "airline_key": "7S",
        "airline_name": "Amadeus Pdf 7S"
    },
    {
        "airline_key": "9S",
        "airline_name": "Amadeus Pdf 9S"
    },
    {
        "airline_key": "9Z",
        "airline_name": "Amadeus Pdf 9Z"
    },
    {
        "airline_key": "0E",
        "airline_name": "Amadeus Presales 0E"
    },
    {
        "airline_key": "7X",
        "airline_name": "Amadeus Seven"
    },
    {
        "airline_key": "6X",
        "airline_name": "Amadeus Six"
    },
    {
        "airline_key": "2X",
        "airline_name": "Amadeus Two"
    },
    {
        "airline_key": "MZ",
        "airline_name": "Amakusa Airlines"
    },
    {
        "airline_key": "HP",
        "airline_name": "Amapola Flyg Ab"
    },
    {
        "airline_key": "Z8",
        "airline_name": "Amaszonas S.A."
    },
    {
        "airline_key": "Z7",
        "airline_name": "Amaszonas Uruguay"
    },
    {
        "airline_key": "0A",
        "airline_name": "Amber Air"
    },
    {
        "airline_key": "AA",
        "airline_name": "American Airlines"
    },
    {
        "airline_key": "WD",
        "airline_name": "Amsterdam Airlines Bv"
    },
    {
        "airline_key": "2V",
        "airline_name": "Amtrak"
    },
    {
        "airline_key": "EH",
        "airline_name": "Ana Wings"
    },
    {
        "airline_key": "OX",
        "airline_name": "Andes Lineas Aereas"
    },
    {
        "airline_key": "2G",
        "airline_name": "Angara Airlines"
    },
    {
        "airline_key": "8K",
        "airline_name": "Angel Airlines"
    },
    {
        "airline_key": "Q3",
        "airline_name": "Anguilla Air Services"
    },
    {
        "airline_key": "OZ",
        "airline_name": "another airline"
    },
    {
        "airline_key": "SO",
        "airline_name": "Apex Airline"
    },
    {
        "airline_key": "GP",
        "airline_name": "APG Airlines"
    },
    {
        "airline_key": "XD",
        "airline_name": "Arc"
    },
    {
        "airline_key": "FG",
        "airline_name": "Ariana Afghan Airlines"
    },
    {
        "airline_key": "W3",
        "airline_name": "Arik Air"
    },
    {
        "airline_key": "IZ",
        "airline_name": "Arkia"
    },
    {
        "airline_key": "6A",
        "airline_name": "Armenia Airways"
    },
    {
        "airline_key": "AG",
        "airline_name": "Aruba Airlines"
    },
    {
        "airline_key": "R7",
        "airline_name": "Aserca"
    },
    {
        "airline_key": "HB",
        "airline_name": "Asia Atlantic Airlines"
    },
    {
        "airline_key": "DM",
        "airline_name": "Asian Air"
    },
    {
        "airline_key": "YJ",
        "airline_name": "Asian Wings Airways"
    },
    {
        "airline_key": "OY",
        "airline_name": "Asiana Airlines"
    },
    {
        "airline_key": "KP",
        "airline_name": "Asky"
    },
    {
        "airline_key": "3V",
        "airline_name": "Asl Airlines Belgium"
    },
    {
        "airline_key": "5O",
        "airline_name": "Asl Airlines France"
    },
    {
        "airline_key": "A2",
        "airline_name": "Astra Airlines"
    },
    {
        "airline_key": "8Y",
        "airline_name": "Astro Air International"
    },
    {
        "airline_key": "I3",
        "airline_name": "Ata Airlines"
    },
    {
        "airline_key": "RC",
        "airline_name": "Atlantic Airways"
    },
    {
        "airline_key": "4X",
        "airline_name": "Atlantic Express Airline"
    },
    {
        "airline_key": "L5",
        "airline_name": "Atlantique Air Assistance"
    },
    {
        "airline_key": "TD",
        "airline_name": "Atlantis Armenian Airlines"
    },
    {
        "airline_key": "2R",
        "airline_name": "Atlantis European Airways"
    },
    {
        "airline_key": "5Y",
        "airline_name": "Atlas Air"
    },
    {
        "airline_key": "KK",
        "airline_name": "AtlasGlobal"
    },
    {
        "airline_key": "UH",
        "airline_name": "Atlasjet Ukraine"
    },
    {
        "airline_key": "UI",
        "airline_name": "Auric Air Services"
    },
    {
        "airline_key": "GR",
        "airline_name": "Aurigny Air Services"
    },
    {
        "airline_key": "HZ",
        "airline_name": "Aurora Airlines"
    },
    {
        "airline_key": "AU",
        "airline_name": "Austral Lineas Aereas"
    },
    {
        "airline_key": "OS",
        "airline_name": "Austrian Airlines"
    },
    {
        "airline_key": "6V",
        "airline_name": "Avanza"
    },
    {
        "airline_key": "YK",
        "airline_name": "Avia Traffic Company"
    },
    {
        "airline_key": "AV",
        "airline_name": "Avianca"
    },
    {
        "airline_key": "A0",
        "airline_name": "Avianca Argentina"
    },
    {
        "airline_key": "O6",
        "airline_name": "Avianca Brasil"
    },
    {
        "airline_key": "LR",
        "airline_name": "Avianca Costa Rica SA"
    },
    {
        "airline_key": "2K",
        "airline_name": "Avianca Ecuador S.A."
    },
    {
        "airline_key": "T0",
        "airline_name": "Avianca Peru S.A."
    },
    {
        "airline_key": "GU",
        "airline_name": "Aviateca"
    },
    {
        "airline_key": "Q4",
        "airline_name": "Aviation Starlink"
    },
    {
        "airline_key": "U3",
        "airline_name": "Avies"
    },
    {
        "airline_key": "X9",
        "airline_name": "Avion Express"
    },
    {
        "airline_key": "9V",
        "airline_name": "Avior"
    },
    {
        "airline_key": "3R",
        "airline_name": "Avior Regional"
    },
    {
        "airline_key": "T1",
        "airline_name": "Avtrasoft Limited"
    },
    {
        "airline_key": "1J",
        "airline_name": "Axess International"
    },
    {
        "airline_key": "J2",
        "airline_name": "Azerbaijan Airlines"
    },
    {
        "airline_key": "ZQ",
        "airline_name": "Azman Air Services"
    },
    {
        "airline_key": "AJ",
        "airline_name": "Aztec Worldwide Airlines"
    },
    {
        "airline_key": "AD",
        "airline_name": "Azul Linhas Aereas Brasileiras"
    },
    {
        "airline_key": "ZF",
        "airline_name": "Azur Air"
    },
    {
        "airline_key": "QU",
        "airline_name": "Azur Air Ukraine Airlines"
    },
    {
        "airline_key": "CJ",
        "airline_name": "BA CityFlyer"
    },
    {
        "airline_key": "J4",
        "airline_name": "Badr Airlines"
    },
    {
        "airline_key": "UP",
        "airline_name": "Bahamasair"
    },
    {
        "airline_key": "BN",
        "airline_name": "Bahrain Air"
    },
    {
        "airline_key": "QH",
        "airline_name": "Bamboo Airways"
    },
    {
        "airline_key": "PG",
        "airline_name": "Bangkok Airways"
    },
    {
        "airline_key": "5B",
        "airline_name": "Bassaka Air"
    },
    {
        "airline_key": "ID",
        "airline_name": "Batik Air Indonesia"
    },
    {
        "airline_key": "BO",
        "airline_name": "Bb Airways"
    },
    {
        "airline_key": "JV",
        "airline_name": "Bearskin Airlines"
    },
    {
        "airline_key": "JD",
        "airline_name": "Beijing Capital Airlines"
    },
    {
        "airline_key": "4T",
        "airline_name": "Belair Airlines"
    },
    {
        "airline_key": "B2",
        "airline_name": "Belavia"
    },
    {
        "airline_key": "L9",
        "airline_name": "Belle Air Europe"
    },
    {
        "airline_key": "CH",
        "airline_name": "Bemidji Airlines"
    },
    {
        "airline_key": "8E",
        "airline_name": "Bering Air"
    },
    {
        "airline_key": "J8",
        "airline_name": "Berjaya Air"
    },
    {
        "airline_key": "8H",
        "airline_name": "BH Air"
    },
    {
        "airline_key": "B3",
        "airline_name": "Bhutan Airlines"
    },
    {
        "airline_key": "Z3",
        "airline_name": "Bidzy Ta Hot Aana Corporation"
    },
    {
        "airline_key": "BG",
        "airline_name": "Biman Bangladesh Airline"
    },
    {
        "airline_key": "3B",
        "airline_name": "Binter Cabo Verde"
    },
    {
        "airline_key": "NT",
        "airline_name": "Binter Canarias"
    },
    {
        "airline_key": "1R",
        "airline_name": "Bird Information Systems"
    },
    {
        "airline_key": "0B",
        "airline_name": "Blue Air Aviation"
    },
    {
        "airline_key": "BZ",
        "airline_name": "Blue Bird Airways"
    },
    {
        "airline_key": "SI",
        "airline_name": "Blue Islands"
    },
    {
        "airline_key": "BV",
        "airline_name": "Blue Panorama Airlines"
    },
    {
        "airline_key": "BM",
        "airline_name": "bmi regional"
    },
    {
        "airline_key": "OB",
        "airline_name": "Boliviana De Aviacion"
    },
    {
        "airline_key": "YB",
        "airline_name": "Bora Jet"
    },
    {
        "airline_key": "4B",
        "airline_name": "Boutique Air"
    },
    {
        "airline_key": "5Q",
        "airline_name": "Bqb Lineas Aereas"
    },
    {
        "airline_key": "DC",
        "airline_name": "Braathens Regional"
    },
    {
        "airline_key": "TF",
        "airline_name": "Braathens Regional Aviation Ab"
    },
    {
        "airline_key": "1X",
        "airline_name": "Branson Air"
    },
    {
        "airline_key": "B1",
        "airline_name": "Bravo Passenger Solution"
    },
    {
        "airline_key": "E6",
        "airline_name": "Bringer Air Cargo"
    },
    {
        "airline_key": "BA",
        "airline_name": "British Airways"
    },
    {
        "airline_key": "SN",
        "airline_name": "Brussels Airlines"
    },
    {
        "airline_key": "RP",
        "airline_name": "Budapest Aircraft Service"
    },
    {
        "airline_key": "U4",
        "airline_name": "Buddha Air"
    },
    {
        "airline_key": "BQ",
        "airline_name": "Bukovyna Airlines"
    },
    {
        "airline_key": "FB",
        "airline_name": "Bulgaria Air"
    },
    {
        "airline_key": "H6",
        "airline_name": "Bulgarian Air Charter"
    },
    {
        "airline_key": "UZ",
        "airline_name": "Buraq Air"
    },
    {
        "airline_key": "XV",
        "airline_name": "BVI Airways"
    },
    {
        "airline_key": "XM",
        "airline_name": "C.A.I. First S.p.A."
    },
    {
        "airline_key": "9Q",
        "airline_name": "Caicos Express Airways"
    },
    {
        "airline_key": "4A",
        "airline_name": "California Pacific"
    },
    {
        "airline_key": "MO",
        "airline_name": "Calm Air International"
    },
    {
        "airline_key": "QC",
        "airline_name": "Camair-Co"
    },
    {
        "airline_key": "KR",
        "airline_name": "Cambodia Airways"
    },
    {
        "airline_key": "K6",
        "airline_name": "Cambodia Angkor Air"
    },
    {
        "airline_key": "BD",
        "airline_name": "Cambodia Bayon Airlines"
    },
    {
        "airline_key": "5T",
        "airline_name": "Canadian North"
    },
    {
        "airline_key": "PM",
        "airline_name": "Canary Fly"
    },
    {
        "airline_key": "C6",
        "airline_name": "CanJet Airlines"
    },
    {
        "airline_key": "9K",
        "airline_name": "Cape Air"
    },
    {
        "airline_key": "IV",
        "airline_name": "Cardiff Aviation Malta Ltd."
    },
    {
        "airline_key": "CV",
        "airline_name": "Cargolux Airlines International"
    },
    {
        "airline_key": "BW",
        "airline_name": "Caribbean Airlines"
    },
    {
        "airline_key": "W8",
        "airline_name": "Caribbean Winds Airlines"
    },
    {
        "airline_key": "V3",
        "airline_name": "Carpatair"
    },
    {
        "airline_key": "KA",
        "airline_name": "Cathay Dragon"
    },
    {
        "airline_key": "CX",
        "airline_name": "Cathay Pacific"
    },
    {
        "airline_key": "KX",
        "airline_name": "Cayman Airways"
    },
    {
        "airline_key": "DG",
        "airline_name": "Cebgo"
    },
    {
        "airline_key": "5J",
        "airline_name": "Cebu Air"
    },
    {
        "airline_key": "C2",
        "airline_name": "Ceiba Intercontinental"
    },
    {
        "airline_key": "5Z",
        "airline_name": "Cemair"
    },
    {
        "airline_key": "9M",
        "airline_name": "Central Mountain Air"
    },
    {
        "airline_key": "M6",
        "airline_name": "Chalair"
    },
    {
        "airline_key": "CE",
        "airline_name": "Chalair Aviation"
    },
    {
        "airline_key": "6Q",
        "airline_name": "Cham Wings Airlines"
    },
    {
        "airline_key": "C5",
        "airline_name": "Champlain Enterprises"
    },
    {
        "airline_key": "9H",
        "airline_name": "Changan Airlines"
    },
    {
        "airline_key": "EU",
        "airline_name": "Chengdu Airlines"
    },
    {
        "airline_key": "ZY",
        "airline_name": "China Air Cargo"
    },
    {
        "airline_key": "CI",
        "airline_name": "China Airlines Ltd."
    },
    {
        "airline_key": "CK",
        "airline_name": "China Cargo Airlines"
    },
    {
        "airline_key": "MU",
        "airline_name": "China Eastern Airlines"
    },
    {
        "airline_key": "G5",
        "airline_name": "China Express Airlines"
    },
    {
        "airline_key": "CZ",
        "airline_name": "China Southern Airlines"
    },
    {
        "airline_key": "KN",
        "airline_name": "China United Airlines"
    },
    {
        "airline_key": "PN",
        "airline_name": "China West Air"
    },
    {
        "airline_key": "X2",
        "airline_name": "China Xinhua Airlines"
    },
    {
        "airline_key": "OQ",
        "airline_name": "Chongqing Airlines"
    },
    {
        "airline_key": "3A",
        "airline_name": "Chu Kong Passenger Transport"
    },
    {
        "airline_key": "QI",
        "airline_name": "Cimber A/S"
    },
    {
        "airline_key": "C7",
        "airline_name": "Cinnamon Air"
    },
    {
        "airline_key": "QG",
        "airline_name": "Citilink Indonesia"
    },
    {
        "airline_key": "CF",
        "airline_name": "City Airline"
    },
    {
        "airline_key": "E8",
        "airline_name": "City Airways"
    },
    {
        "airline_key": "WX",
        "airline_name": "Cityjet"
    },
    {
        "airline_key": "IO",
        "airline_name": "Closed Jsc Iraero"
    },
    {
        "airline_key": "CC",
        "airline_name": "CM Airlines"
    },
    {
        "airline_key": "CQ",
        "airline_name": "Coastal Travels"
    },
    {
        "airline_key": "CO",
        "airline_name": "Cobaltair"
    },
    {
        "airline_key": "GY",
        "airline_name": "Colorful Guizhou Airline"
    },
    {
        "airline_key": "ZO",
        "airline_name": "Colorful Yunnan General Aviation"
    },
    {
        "airline_key": "MN",
        "airline_name": "Comair Ltd"
    },
    {
        "airline_key": "O5",
        "airline_name": "Comores Aviation International"
    },
    {
        "airline_key": "BU",
        "airline_name": "Compagnie Africaine D'Aviation"
    },
    {
        "airline_key": "CP",
        "airline_name": "Compass Airlines"
    },
    {
        "airline_key": "DE",
        "airline_name": "Condor"
    },
    {
        "airline_key": "DF",
        "airline_name": "Condor Berlin"
    },
    {
        "airline_key": "8Z",
        "airline_name": "Congo Airways"
    },
    {
        "airline_key": "LF",
        "airline_name": "Contour Airlines"
    },
    {
        "airline_key": "V0",
        "airline_name": "Conviasa"
    },
    {
        "airline_key": "CM",
        "airline_name": "Copa Airlines"
    },
    {
        "airline_key": "XC",
        "airline_name": "Corendon Airlines"
    },
    {
        "airline_key": "XR",
        "airline_name": "Corendon Airlines Europe"
    },
    {
        "airline_key": "CD",
        "airline_name": "Corendon Dutch Airlines"
    },
    {
        "airline_key": "SS",
        "airline_name": "Corsair"
    },
    {
        "airline_key": "8C",
        "airline_name": "Cotai Water Jet"
    },
    {
        "airline_key": "Other",
        "airline_name": "Croatia Airlines"
    },
    {
        "airline_key": "C8",
        "airline_name": "Cronos Airlines"
    },
    {
        "airline_key": "I1",
        "airline_name": "CTS Viaggi"
    },
    {
        "airline_key": "CU",
        "airline_name": "Cubana de Aviaci\u00f3n"
    },
    {
        "airline_key": "CY",
        "airline_name": "Cyprus Airways"
    },
    {
        "airline_key": "OK",
        "airline_name": "Czech Airlines"
    },
    {
        "airline_key": "D3",
        "airline_name": "Daallo Airlines"
    },
    {
        "airline_key": "OP",
        "airline_name": "Dac International Airlines"
    },
    {
        "airline_key": "N2",
        "airline_name": "Dagestan Airlines"
    },
    {
        "airline_key": "9J",
        "airline_name": "Dana Airlines Limited"
    },
    {
        "airline_key": "DX",
        "airline_name": "Danish Air Transport"
    },
    {
        "airline_key": "D4",
        "airline_name": "Dart Limited Trust"
    },
    {
        "airline_key": "F7",
        "airline_name": "Darwin Airline"
    },
    {
        "airline_key": "D5",
        "airline_name": "Dauair"
    },
    {
        "airline_key": "DL",
        "airline_name": "Delta Air Lines"
    },
    {
        "airline_key": "DQ",
        "airline_name": "Delta Connection"
    },
    {
        "airline_key": "D9",
        "airline_name": "Dena Airways"
    },
    {
        "airline_key": "2A",
        "airline_name": "Deutsche Bahn AG"
    },
    {
        "airline_key": "Z6",
        "airline_name": "Dniproavia"
    },
    {
        "airline_key": "3D",
        "airline_name": "Dokasch"
    },
    {
        "airline_key": "DZ",
        "airline_name": "Donghai Airlines"
    },
    {
        "airline_key": "R6",
        "airline_name": "DOT LT"
    },
    {
        "airline_key": "DH",
        "airline_name": "Douniah Airlines"
    },
    {
        "airline_key": "KB",
        "airline_name": "Druk Air"
    },
    {
        "airline_key": "B5",
        "airline_name": "East African Safari Air"
    },
    {
        "airline_key": "ZE",
        "airline_name": "Eastar Jet"
    },
    {
        "airline_key": "EA",
        "airline_name": "Eastern Airlines"
    },
    {
        "airline_key": "T3",
        "airline_name": "Eastern Airways"
    },
    {
        "airline_key": "1T",
        "airline_name": "East-Line JSC"
    },
    {
        "airline_key": "VE",
        "airline_name": "Easyfly S.A."
    },
    {
        "airline_key": "U2",
        "airline_name": "Easyjet"
    },
    {
        "airline_key": "DS",
        "airline_name": "easyJet Switzerland"
    },
    {
        "airline_key": "WK",
        "airline_name": "Edelweiss Air"
    },
    {
        "airline_key": "1C",
        "airline_name": "EDS Information Business"
    },
    {
        "airline_key": "MS",
        "airline_name": "Egyptair"
    },
    {
        "airline_key": "LY",
        "airline_name": "El Al Israel Airlines"
    },
    {
        "airline_key": "1Y",
        "airline_name": "Electronic Data Systems"
    },
    {
        "airline_key": "7Q",
        "airline_name": "Elite Airways"
    },
    {
        "airline_key": "EL",
        "airline_name": "Ellinair"
    },
    {
        "airline_key": "EK",
        "airline_name": "Emirates"
    },
    {
        "airline_key": "EM",
        "airline_name": "Empire Airlines"
    },
    {
        "airline_key": "9E",
        "airline_name": "Endeavor Air"
    },
    {
        "airline_key": "MQ",
        "airline_name": "Envoy Air"
    },
    {
        "airline_key": "E7",
        "airline_name": "Equaflight Service"
    },
    {
        "airline_key": "LC",
        "airline_name": "Equatorial Congo Airline"
    },
    {
        "airline_key": "B8",
        "airline_name": "Eritrean Airlines"
    },
    {
        "airline_key": "EG",
        "airline_name": "Ernest Airlines"
    },
    {
        "airline_key": "2U",
        "airline_name": "Ero Sun D'Or"
    },
    {
        "airline_key": "L1",
        "airline_name": "E-Savtravel"
    },
    {
        "airline_key": "ES",
        "airline_name": "Estelar"
    },
    {
        "airline_key": "E4",
        "airline_name": "Estelar Latinoamerica"
    },
    {
        "airline_key": "ET",
        "airline_name": "Ethiopian Airlines"
    },
    {
        "airline_key": "ZU",
        "airline_name": "Ethiopian Mozambique"
    },
    {
        "airline_key": "EY",
        "airline_name": "Etihad Airways"
    },
    {
        "airline_key": "6Z",
        "airline_name": "Eurasia Air"
    },
    {
        "airline_key": "YU",
        "airline_name": "EuroAtlantic Airways"
    },
    {
        "airline_key": "K2",
        "airline_name": "Eurolot"
    },
    {
        "airline_key": "QY",
        "airline_name": "European Air Transport"
    },
    {
        "airline_key": "WL",
        "airline_name": "European Coastal Airline"
    },
    {
        "airline_key": "H5",
        "airline_name": "European Coastal Airlines Ltd."
    },
    {
        "airline_key": "9F",
        "airline_name": "Eurostar"
    },
    {
        "airline_key": "EW",
        "airline_name": "Eurowings"
    },
    {
        "airline_key": "E2",
        "airline_name": "Eurowings Europe"
    },
    {
        "airline_key": "BR",
        "airline_name": "EVA Air"
    },
    {
        "airline_key": "E9",
        "airline_name": "Evelop Airlines"
    },
    {
        "airline_key": "5V",
        "airline_name": "Everts"
    },
    {
        "airline_key": "ZD",
        "airline_name": "Ewa Air"
    },
    {
        "airline_key": "X7",
        "airline_name": "Exec Air"
    },
    {
        "airline_key": "6G",
        "airline_name": "Executive Express"
    },
    {
        "airline_key": "EV",
        "airline_name": "ExpressJet Airlines"
    },
    {
        "airline_key": "MG",
        "airline_name": "Eznis Airways"
    },
    {
        "airline_key": "2F",
        "airline_name": "Fair Aviation (PTY) Ltd."
    },
    {
        "airline_key": "1Z",
        "airline_name": "Fantasia Info Network Lt"
    },
    {
        "airline_key": "FE",
        "airline_name": "Far Eastern"
    },
    {
        "airline_key": "F1",
        "airline_name": "Farelogix"
    },
    {
        "airline_key": "QE",
        "airline_name": "Fars Qeshm Airlines"
    },
    {
        "airline_key": "FN",
        "airline_name": "Fastjet Zimbabwe"
    },
    {
        "airline_key": "7V",
        "airline_name": "Federal Airlines"
    },
    {
        "airline_key": "FX",
        "airline_name": "Fedex"
    },
    {
        "airline_key": "FO",
        "airline_name": "Felix Airways"
    },
    {
        "airline_key": "FJ",
        "airline_name": "Fiji Airways"
    },
    {
        "airline_key": "AY",
        "airline_name": "Finnair"
    },
    {
        "airline_key": "7F",
        "airline_name": "First Air"
    },
    {
        "airline_key": "5H",
        "airline_name": "Five Fourty Aviation"
    },
    {
        "airline_key": "F8",
        "airline_name": "Flair Airlines"
    },
    {
        "airline_key": "W2",
        "airline_name": "Flexflight"
    },
    {
        "airline_key": "F5",
        "airline_name": "Fly 540"
    },
    {
        "airline_key": "8W",
        "airline_name": "Fly Always"
    },
    {
        "airline_key": "T2",
        "airline_name": "Fly Art"
    },
    {
        "airline_key": "IF",
        "airline_name": "Fly Baghdad Airlines"
    },
    {
        "airline_key": "7B",
        "airline_name": "Fly Blue Crane"
    },
    {
        "airline_key": "EF",
        "airline_name": "Fly Caminter"
    },
    {
        "airline_key": "F6",
        "airline_name": "Fly Compass Service"
    },
    {
        "airline_key": "FC",
        "airline_name": "Fly Corporate"
    },
    {
        "airline_key": "OJ",
        "airline_name": "Fly Jamaica Airways"
    },
    {
        "airline_key": "5F",
        "airline_name": "Fly One"
    },
    {
        "airline_key": "5L",
        "airline_name": "Fly Salone"
    },
    {
        "airline_key": "VF",
        "airline_name": "Fly Viking"
    },
    {
        "airline_key": "F3",
        "airline_name": "flyadeal"
    },
    {
        "airline_key": "BE",
        "airline_name": "Flybe"
    },
    {
        "airline_key": "4J",
        "airline_name": "Flydamas Airlines"
    },
    {
        "airline_key": "FZ",
        "airline_name": "Flydubai"
    },
    {
        "airline_key": "FT",
        "airline_name": "FlyEgypt"
    },
    {
        "airline_key": "FQ",
        "airline_name": "Flyest Lineas Aereas"
    },
    {
        "airline_key": "FY",
        "airline_name": "Flyfirefly"
    },
    {
        "airline_key": "XY",
        "airline_name": "Flynas"
    },
    {
        "airline_key": "ND",
        "airline_name": "FMI Air"
    },
    {
        "airline_key": "Q5",
        "airline_name": "Forty Mile Air"
    },
    {
        "airline_key": "FH",
        "airline_name": "Freebird Airlines"
    },
    {
        "airline_key": "4F",
        "airline_name": "Freedom Airline Express"
    },
    {
        "airline_key": "BF",
        "airline_name": "French Bee"
    },
    {
        "airline_key": "RD",
        "airline_name": "French Military Force"
    },
    {
        "airline_key": "F9",
        "airline_name": "Frontier Airlines"
    },
    {
        "airline_key": "JH",
        "airline_name": "Fuji Dream Airlines"
    },
    {
        "airline_key": "FU",
        "airline_name": "Fuzhou Airlines"
    },
    {
        "airline_key": "1V",
        "airline_name": "Galileo International"
    },
    {
        "airline_key": "3G",
        "airline_name": "Gambia Bird Airlines Ltd"
    },
    {
        "airline_key": "GA",
        "airline_name": "Garuda Indonesia"
    },
    {
        "airline_key": "4G",
        "airline_name": "Gazpromavia"
    },
    {
        "airline_key": "9D",
        "airline_name": "Genghis Khan Airlines"
    },
    {
        "airline_key": "A9",
        "airline_name": "Georgian Airways"
    },
    {
        "airline_key": "ST",
        "airline_name": "Germania"
    },
    {
        "airline_key": "GM",
        "airline_name": "Germania Flug AG"
    },
    {
        "airline_key": "4U",
        "airline_name": "Germanwings"
    },
    {
        "airline_key": "GC",
        "airline_name": "Global Feeder Services"
    },
    {
        "airline_key": "GH",
        "airline_name": "Globus Llc"
    },
    {
        "airline_key": "Z5",
        "airline_name": "Gmg Airlines"
    },
    {
        "airline_key": "G8",
        "airline_name": "Go Airlines"
    },
    {
        "airline_key": "G7",
        "airline_name": "Gojet Airlines"
    },
    {
        "airline_key": "G3",
        "airline_name": "Gol Linhas Aerea S/A"
    },
    {
        "airline_key": "Y5",
        "airline_name": "Golden Myanmar Airlines"
    },
    {
        "airline_key": "G6",
        "airline_name": "Gowair"
    },
    {
        "airline_key": "CN",
        "airline_name": "Grand China Air"
    },
    {
        "airline_key": "GV",
        "airline_name": "Grant Aviation"
    },
    {
        "airline_key": "ZK",
        "airline_name": "Great Lakes Aviation"
    },
    {
        "airline_key": "R2",
        "airline_name": "Groupe Transair"
    },
    {
        "airline_key": "ZG",
        "airline_name": "Groznyy Avia"
    },
    {
        "airline_key": "6P",
        "airline_name": "Gryphon Airline"
    },
    {
        "airline_key": "GX",
        "airline_name": "Guangxi Beibu Gulf Airlines"
    },
    {
        "airline_key": "G2",
        "airline_name": "Guinea Airlines"
    },
    {
        "airline_key": "GF",
        "airline_name": "Gulf Air"
    },
    {
        "airline_key": "HR",
        "airline_name": "Hahn Air"
    },
    {
        "airline_key": "H1",
        "airline_name": "Hahn Air Systems"
    },
    {
        "airline_key": "X1",
        "airline_name": "Hahn Air Technologies"
    },
    {
        "airline_key": "HU",
        "airline_name": "Hainan Airlines"
    },
    {
        "airline_key": "7Z",
        "airline_name": "Halcyon Air Cabo Verde"
    },
    {
        "airline_key": "HA",
        "airline_name": "Hawaiian Airlines"
    },
    {
        "airline_key": "BH",
        "airline_name": "Hawkair"
    },
    {
        "airline_key": "NS",
        "airline_name": "Hebei Airlines"
    },
    {
        "airline_key": "YO",
        "airline_name": "Heli Air Monaco"
    },
    {
        "airline_key": "HS",
        "airline_name": "Heli Securite"
    },
    {
        "airline_key": "UV",
        "airline_name": "Helicopteros del Sureste"
    },
    {
        "airline_key": "JB",
        "airline_name": "Helijet International"
    },
    {
        "airline_key": "HJ",
        "airline_name": "Hellas Jet"
    },
    {
        "airline_key": "HT",
        "airline_name": "Hellenic Imperial Airways"
    },
    {
        "airline_key": "2L",
        "airline_name": "Helvetic Airways"
    },
    {
        "airline_key": "VD",
        "airline_name": "Hennan Airlines"
    },
    {
        "airline_key": "H3",
        "airline_name": "Hermes Airlines"
    },
    {
        "airline_key": "IU",
        "airline_name": "Hevi Lift (PNG) Pty Ltd"
    },
    {
        "airline_key": "UD",
        "airline_name": "Hex Air"
    },
    {
        "airline_key": "HHR",
        "airline_name": "HHR"
    },
    {
        "airline_key": "5K",
        "airline_name": "Hi Fly Transportes Aereo"
    },
    {
        "airline_key": "H9",
        "airline_name": "Himalaya Airlines"
    },
    {
        "airline_key": "OI",
        "airline_name": "Hinterland Aviation"
    },
    {
        "airline_key": "HX",
        "airline_name": "Hong Kong Airlines"
    },
    {
        "airline_key": "UO",
        "airline_name": "Hong Kong Express Airways"
    },
    {
        "airline_key": "HOP",
        "airline_name": "HOP"
    },
    {
        "airline_key": "DB",
        "airline_name": "HOP Brit Air"
    },
    {
        "airline_key": "YS",
        "airline_name": "Hop Regional"
    },
    {
        "airline_key": "QX",
        "airline_name": "Horizon Air"
    },
    {
        "airline_key": "MR",
        "airline_name": "Hunnu Air"
    },
    {
        "airline_key": "XB",
        "airline_name": "IATA"
    },
    {
        "airline_key": "II",
        "airline_name": "IBC Airways Inc"
    },
    {
        "airline_key": "IB",
        "airline_name": "Iberia"
    },
    {
        "airline_key": "I2",
        "airline_name": "Iberia Express"
    },
    {
        "airline_key": "FW",
        "airline_name": "Ibex Airlines"
    },
    {
        "airline_key": "V1",
        "airline_name": "IBS Software Services Americas"
    },
    {
        "airline_key": "FI",
        "airline_name": "Icelandair"
    },
    {
        "airline_key": "4I",
        "airline_name": "Ihy Izmir Havayollari"
    },
    {
        "airline_key": "V8",
        "airline_name": "Iliamna Air"
    },
    {
        "airline_key": "6E",
        "airline_name": "Indigo"
    },
    {
        "airline_key": "XT",
        "airline_name": "Indonesia Airasia Extra"
    },
    {
        "airline_key": "1F",
        "airline_name": "Infini Travel Information"
    },
    {
        "airline_key": "8I",
        "airline_name": "Insel Air Aruba"
    },
    {
        "airline_key": "7I",
        "airline_name": "Insel Air International"
    },
    {
        "airline_key": "D6",
        "airline_name": "Inter Air"
    },
    {
        "airline_key": "I7",
        "airline_name": "Inter Iles Air"
    },
    {
        "airline_key": "JY",
        "airline_name": "Intercaribbean Airways"
    },
    {
        "airline_key": "4O",
        "airline_name": "Interjet"
    },
    {
        "airline_key": "3L",
        "airline_name": "Intersky Luftfahrt"
    },
    {
        "airline_key": "IR",
        "airline_name": "Iran Air"
    },
    {
        "airline_key": "B9",
        "airline_name": "Iran Air Tours"
    },
    {
        "airline_key": "EP",
        "airline_name": "Iran Aseman Airlines"
    },
    {
        "airline_key": "IA",
        "airline_name": "Iraqi Airways"
    },
    {
        "airline_key": "WP",
        "airline_name": "Island Air"
    },
    {
        "airline_key": "Q2",
        "airline_name": "Island Aviation Services"
    },
    {
        "airline_key": "T6",
        "airline_name": "Island Transvoyager"
    },
    {
        "airline_key": "6H",
        "airline_name": "Israir Airlines"
    },
    {
        "airline_key": "AZ",
        "airline_name": "ITA Airways"
    },
    {
        "airline_key": "1U",
        "airline_name": "Ita Software"
    },
    {
        "airline_key": "GI",
        "airline_name": "Itek Air"
    },
    {
        "airline_key": "I8",
        "airline_name": "Izhavia"
    },
    {
        "airline_key": "JM",
        "airline_name": "Jambojet"
    },
    {
        "airline_key": "JC",
        "airline_name": "Japan Air Commuter"
    },
    {
        "airline_key": "JL",
        "airline_name": "Japan Airlines"
    },
    {
        "airline_key": "NU",
        "airline_name": "Japan Transocean Air"
    },
    {
        "airline_key": "J9",
        "airline_name": "Jazeera Airways"
    },
    {
        "airline_key": "QK",
        "airline_name": "Jazz Aviation"
    },
    {
        "airline_key": "QD",
        "airline_name": "Jc Cambodia Intl Airlines"
    },
    {
        "airline_key": "7C",
        "airline_name": "Jeju Air"
    },
    {
        "airline_key": "9W",
        "airline_name": "Jet Airways"
    },
    {
        "airline_key": "JF",
        "airline_name": "Jet Asia Airways"
    },
    {
        "airline_key": "PP",
        "airline_name": "Jet Aviation Business"
    },
    {
        "airline_key": "S2",
        "airline_name": "Jet Lite"
    },
    {
        "airline_key": "JO",
        "airline_name": "Jet Time"
    },
    {
        "airline_key": "LS",
        "airline_name": "Jet2.Com"
    },
    {
        "airline_key": "B6",
        "airline_name": "JetBlue Airways"
    },
    {
        "airline_key": "JG",
        "airline_name": "Jetgo Australia"
    },
    {
        "airline_key": "J0",
        "airline_name": "Jetlink Express"
    },
    {
        "airline_key": "JA",
        "airline_name": "JetSMART SpA"
    },
    {
        "airline_key": "JQ",
        "airline_name": "Jetstar"
    },
    {
        "airline_key": "3K",
        "airline_name": "Jetstar Asia"
    },
    {
        "airline_key": "GK",
        "airline_name": "Jetstar Japan"
    },
    {
        "airline_key": "BL",
        "airline_name": "Jetstar Pacific Airlines"
    },
    {
        "airline_key": "XE",
        "airline_name": "JetSuiteX"
    },
    {
        "airline_key": "WU",
        "airline_name": "Jetways Airlines Limited"
    },
    {
        "airline_key": "RY",
        "airline_name": "Jiangxi Air"
    },
    {
        "airline_key": "LJ",
        "airline_name": "Jin Air"
    },
    {
        "airline_key": "1Q",
        "airline_name": "Joint-Stock Company.Ital"
    },
    {
        "airline_key": "JN",
        "airline_name": "Joon"
    },
    {
        "airline_key": "R5",
        "airline_name": "Jordan Aviation"
    },
    {
        "airline_key": "JR",
        "airline_name": "Joy Air"
    },
    {
        "airline_key": "KC",
        "airline_name": "JSC Air Astana"
    },
    {
        "airline_key": "DV",
        "airline_name": "JSC Aircompany Scat"
    },
    {
        "airline_key": "R3",
        "airline_name": "JSC Aircompany Yakutia"
    },
    {
        "airline_key": "A4",
        "airline_name": "JSC Azimuth Airlines"
    },
    {
        "airline_key": "Z9",
        "airline_name": "JSC Bek Air"
    },
    {
        "airline_key": "ZS",
        "airline_name": "JSC Kazaviaspas"
    },
    {
        "airline_key": "RT",
        "airline_name": "JSC UVT Aero"
    },
    {
        "airline_key": "JZ",
        "airline_name": "Jubba Airways"
    },
    {
        "airline_key": "3J",
        "airline_name": "Jubba Airways (Kenya)"
    },
    {
        "airline_key": "HO",
        "airline_name": "Juneyao Airlines"
    },
    {
        "airline_key": "RQ",
        "airline_name": "Kam Air"
    },
    {
        "airline_key": "K8",
        "airline_name": "Kan Air"
    },
    {
        "airline_key": "U5",
        "airline_name": "Karinou Airlines"
    },
    {
        "airline_key": "5R",
        "airline_name": "Karthago Airlines"
    },
    {
        "airline_key": "3Y",
        "airline_name": "Kartika Airlines"
    },
    {
        "airline_key": "NV",
        "airline_name": "Karun Airlines"
    },
    {
        "airline_key": "3Q",
        "airline_name": "Kc International Airlines"
    },
    {
        "airline_key": "M5",
        "airline_name": "Kenmore Air"
    },
    {
        "airline_key": "4K",
        "airline_name": "Kenn Borek Air"
    },
    {
        "airline_key": "KQ",
        "airline_name": "Kenya Airways"
    },
    {
        "airline_key": "KG",
        "airline_name": "Key Lime Air Corporation"
    },
    {
        "airline_key": "KW",
        "airline_name": "Kharkiv Airlines"
    },
    {
        "airline_key": "Y9",
        "airline_name": "Kish Airlines"
    },
    {
        "airline_key": "WA",
        "airline_name": "Klm Cityhopper"
    },
    {
        "airline_key": "KL",
        "airline_name": "KLM Royal Dutch Airlines"
    },
    {
        "airline_key": "7K",
        "airline_name": "Kogalymavia Airlines"
    },
    {
        "airline_key": "KE",
        "airline_name": "Korean Air"
    },
    {
        "airline_key": "KI",
        "airline_name": "Krasavia"
    },
    {
        "airline_key": "KY",
        "airline_name": "Kunming Airlines"
    },
    {
        "airline_key": "KU",
        "airline_name": "Kuwait Airways"
    },
    {
        "airline_key": "6K",
        "airline_name": "Kyrgyz Trans Avia"
    },
    {
        "airline_key": "R8",
        "airline_name": "Kyrgyzstan Airlines"
    },
    {
        "airline_key": "B0",
        "airline_name": "La Compagnie"
    },
    {
        "airline_key": "WJ",
        "airline_name": "Labrador Airways Limited"
    },
    {
        "airline_key": "TM",
        "airline_name": "Lam Mozambique"
    },
    {
        "airline_key": "UC",
        "airline_name": "Lan Chile Cargo"
    },
    {
        "airline_key": "LQ",
        "airline_name": "Lanmei Airlines"
    },
    {
        "airline_key": "QV",
        "airline_name": "Lao Airlines"
    },
    {
        "airline_key": "LK",
        "airline_name": "Lao Skyway"
    },
    {
        "airline_key": "4M",
        "airline_name": "Latam Airlines Argentina"
    },
    {
        "airline_key": "JJ",
        "airline_name": "Latam Airlines Brasil"
    },
    {
        "airline_key": "LU",
        "airline_name": "Latam Airlines Chile"
    },
    {
        "airline_key": "4C",
        "airline_name": "LATAM Airlines Colombia"
    },
    {
        "airline_key": "XL",
        "airline_name": "LATAM Airlines Ecuador"
    },
    {
        "airline_key": "LA",
        "airline_name": "LATAM Airlines Group"
    },
    {
        "airline_key": "PZ",
        "airline_name": "Latam Airlines Paraguay"
    },
    {
        "airline_key": "LP",
        "airline_name": "Latam Airlines Peru"
    },
    {
        "airline_key": "LW",
        "airline_name": "Latin American Wings"
    },
    {
        "airline_key": "QJ",
        "airline_name": "Latpass Airlines"
    },
    {
        "airline_key": "OE",
        "airline_name": "Laudamotion"
    },
    {
        "airline_key": "W4",
        "airline_name": "LC Peru"
    },
    {
        "airline_key": "N5",
        "airline_name": "Les Investissements Nolinor"
    },
    {
        "airline_key": "HE",
        "airline_name": "LGW Luftfahrtges Walter"
    },
    {
        "airline_key": "LI",
        "airline_name": "Liat"
    },
    {
        "airline_key": "LN",
        "airline_name": "Libyan Airlines"
    },
    {
        "airline_key": "YL",
        "airline_name": "Libyan Wings"
    },
    {
        "airline_key": "QL",
        "airline_name": "Linea Aerea de Servicio"
    },
    {
        "airline_key": "8J",
        "airline_name": "Linea Aerea Eco Jet"
    },
    {
        "airline_key": "LD",
        "airline_name": "Linea Turistica"
    },
    {
        "airline_key": "O2",
        "airline_name": "Linear Air Taxi"
    },
    {
        "airline_key": "YQ",
        "airline_name": "Link Conexion Aerea"
    },
    {
        "airline_key": "JT",
        "airline_name": "Lion Airlines"
    },
    {
        "airline_key": "LM",
        "airline_name": "Loganair"
    },
    {
        "airline_key": "LT",
        "airline_name": "Longjiang Airlines"
    },
    {
        "airline_key": "LO",
        "airline_name": "LOT Polish Airlines"
    },
    {
        "airline_key": "8L",
        "airline_name": "Lucky Air"
    },
    {
        "airline_key": "LH",
        "airline_name": "Lufthansa"
    },
    {
        "airline_key": "CL",
        "airline_name": "Lufthansa Cityline"
    },
    {
        "airline_key": "S1",
        "airline_name": "Lufthansa Systems"
    },
    {
        "airline_key": "L7",
        "airline_name": "Lugansk Airlines"
    },
    {
        "airline_key": "LG",
        "airline_name": "Luxair"
    },
    {
        "airline_key": "L3",
        "airline_name": "Lynx Aviation"
    },
    {
        "airline_key": "7D",
        "airline_name": "Madagasikara Airways"
    },
    {
        "airline_key": "W5",
        "airline_name": "Mahan Airlines"
    },
    {
        "airline_key": "3W",
        "airline_name": "Malawian Airlines"
    },
    {
        "airline_key": "MH",
        "airline_name": "Malaysia Airlines"
    },
    {
        "airline_key": "OD",
        "airline_name": "Malindo Airways"
    },
    {
        "airline_key": "AE",
        "airline_name": "Mandarin Airlines"
    },
    {
        "airline_key": "JE",
        "airline_name": "Mango"
    },
    {
        "airline_key": "7Y",
        "airline_name": "Mann Yadanarpon Airlines"
    },
    {
        "airline_key": "NM",
        "airline_name": "Manx2"
    },
    {
        "airline_key": "7M",
        "airline_name": "Map Linhas Aereas"
    },
    {
        "airline_key": "M7",
        "airline_name": "Marsland Aviation"
    },
    {
        "airline_key": "MP",
        "airline_name": "Martinair"
    },
    {
        "airline_key": "YD",
        "airline_name": "Mauritania Airways"
    },
    {
        "airline_key": "L6",
        "airline_name": "Mauritanian Airlines Int"
    },
    {
        "airline_key": "VM",
        "airline_name": "Max Air Limited"
    },
    {
        "airline_key": "2M",
        "airline_name": "Maya Island Air"
    },
    {
        "airline_key": "VL",
        "airline_name": "Med View Airlines"
    },
    {
        "airline_key": "JI",
        "airline_name": "Meraj Air"
    },
    {
        "airline_key": "WC",
        "airline_name": "Meregrass"
    },
    {
        "airline_key": "YV",
        "airline_name": "Mesa Airlines"
    },
    {
        "airline_key": "MX",
        "airline_name": "Mexicana"
    },
    {
        "airline_key": "M2",
        "airline_name": "Mhs Aviation"
    },
    {
        "airline_key": "LL",
        "airline_name": "Miami Air International"
    },
    {
        "airline_key": "OM",
        "airline_name": "MIAT Mongolian Airlines"
    },
    {
        "airline_key": "8G",
        "airline_name": "Mid Africa Aviation"
    },
    {
        "airline_key": "ME",
        "airline_name": "Middle East Airlines"
    },
    {
        "airline_key": "IM",
        "airline_name": "Mint Lineas Aereas"
    },
    {
        "airline_key": "6R",
        "airline_name": "Mirny Air"
    },
    {
        "airline_key": "M4",
        "airline_name": "Mistral Air"
    },
    {
        "airline_key": "MB",
        "airline_name": "Mng Airlines Cargo"
    },
    {
        "airline_key": "MW",
        "airline_name": "Mokulele Flight Service"
    },
    {
        "airline_key": "QM",
        "airline_name": "Monacair"
    },
    {
        "airline_key": "YM",
        "airline_name": "Montenegro Airlines"
    },
    {
        "airline_key": "5M",
        "airline_name": "Montserrat Airways"
    },
    {
        "airline_key": "M9",
        "airline_name": "Motor-Sich JSC"
    },
    {
        "airline_key": "3E",
        "airline_name": "Multi Aero"
    },
    {
        "airline_key": "8M",
        "airline_name": "Myanmar Airways Intl"
    },
    {
        "airline_key": "UB",
        "airline_name": "Myanmar National Airlines"
    },
    {
        "airline_key": "MJ",
        "airline_name": "Myway Airlines"
    },
    {
        "airline_key": "IC",
        "airline_name": "Nacil Indian Airline"
    },
    {
        "airline_key": "IN",
        "airline_name": "Nam Air"
    },
    {
        "airline_key": "N8",
        "airline_name": "National Airlines"
    },
    {
        "airline_key": "9Y",
        "airline_name": "National Airways"
    },
    {
        "airline_key": "NC",
        "airline_name": "National Jet Systems"
    },
    {
        "airline_key": "5C",
        "airline_name": "Nature Air"
    },
    {
        "airline_key": "ON",
        "airline_name": "Nauru Airlines"
    },
    {
        "airline_key": "1N",
        "airline_name": "Navitaire New Skies"
    },
    {
        "airline_key": "1L",
        "airline_name": "Navitaire Open Skies"
    },
    {
        "airline_key": "ZN",
        "airline_name": "Naysa"
    },
    {
        "airline_key": "YA",
        "airline_name": "Nego Airline One"
    },
    {
        "airline_key": "NO",
        "airline_name": "Neos Spa"
    },
    {
        "airline_key": "RA",
        "airline_name": "Nepal Airlines"
    },
    {
        "airline_key": "NE",
        "airline_name": "Nesma Airlines"
    },
    {
        "airline_key": "NA",
        "airline_name": "Nesma Airlines Company"
    },
    {
        "airline_key": "1I",
        "airline_name": "Netjets Aviation"
    },
    {
        "airline_key": "EJ",
        "airline_name": "New England Airlines"
    },
    {
        "airline_key": "E3",
        "airline_name": "New Gen"
    },
    {
        "airline_key": "2N",
        "airline_name": "Nextjet"
    },
    {
        "airline_key": "N7",
        "airline_name": "NHT Linhas Aereas"
    },
    {
        "airline_key": "6N",
        "airline_name": "Niger Airlines"
    },
    {
        "airline_key": "NJ",
        "airline_name": "Niger Airways"
    },
    {
        "airline_key": "HG",
        "airline_name": "Niki"
    },
    {
        "airline_key": "NP",
        "airline_name": "Nile Air"
    },
    {
        "airline_key": "DD",
        "airline_name": "Nok Air"
    },
    {
        "airline_key": "XW",
        "airline_name": "Nokscoot Airlines"
    },
    {
        "airline_key": "N6",
        "airline_name": "Nomad Aviation"
    },
    {
        "airline_key": "XH",
        "airline_name": "Non IATA Codeshare Carrier"
    },
    {
        "airline_key": "N4",
        "airline_name": "Nord Wind"
    },
    {
        "airline_key": "Y7",
        "airline_name": "NordStar"
    },
    {
        "airline_key": "M3",
        "airline_name": "North Flying AS"
    },
    {
        "airline_key": "HW",
        "airline_name": "North Wright Air"
    },
    {
        "airline_key": "NW",
        "airline_name": "Northwest Airlines"
    },
    {
        "airline_key": "J3",
        "airline_name": "Northwestern Air Lease"
    },
    {
        "airline_key": "DN",
        "airline_name": "Norwegian Air Argentina"
    },
    {
        "airline_key": "D8",
        "airline_name": "Norwegian Air International Ltd"
    },
    {
        "airline_key": "DY",
        "airline_name": "Norwegian Air Shuttle"
    },
    {
        "airline_key": "LE",
        "airline_name": "Norwegian Air Sweden Ab"
    },
    {
        "airline_key": "DI",
        "airline_name": "Norwegian Air Uk"
    },
    {
        "airline_key": "BJ",
        "airline_name": "Nouvelair"
    },
    {
        "airline_key": "N9",
        "airline_name": "Nova Airlines"
    },
    {
        "airline_key": "O9",
        "airline_name": "Nova Airways"
    },
    {
        "airline_key": "VQ",
        "airline_name": "Novoair"
    },
    {
        "airline_key": "ZC",
        "airline_name": "Nu Aero Ltd"
    },
    {
        "airline_key": "2Q",
        "airline_name": "Nuovo Trasporto Viaggiatori"
    },
    {
        "airline_key": "CR",
        "airline_name": "OAG Worldwide"
    },
    {
        "airline_key": "KO",
        "airline_name": "OJSC Komiaviatrans"
    },
    {
        "airline_key": "BK",
        "airline_name": "Okay Airways"
    },
    {
        "airline_key": "OA",
        "airline_name": "Olympic Air"
    },
    {
        "airline_key": "WY",
        "airline_name": "Oman Air"
    },
    {
        "airline_key": "IP",
        "airline_name": "One Airlines"
    },
    {
        "airline_key": "C0",
        "airline_name": "One Caribbean"
    },
    {
        "airline_key": "8Q",
        "airline_name": "Onur Air"
    },
    {
        "airline_key": "LV",
        "airline_name": "OpenSkies"
    },
    {
        "airline_key": "O4",
        "airline_name": "Orange2Fly Airlines"
    },
    {
        "airline_key": "6O",
        "airline_name": "Orbest (GHD)"
    },
    {
        "airline_key": "RF",
        "airline_name": "Ord Air Charter PTY LTD"
    },
    {
        "airline_key": "OW",
        "airline_name": "Orient Thai Airlines"
    },
    {
        "airline_key": "OC",
        "airline_name": "Oriental Air Bridge"
    },
    {
        "airline_key": "OF",
        "airline_name": "Overland Airways"
    },
    {
        "airline_key": "3F",
        "airline_name": "Pacific Airways"
    },
    {
        "airline_key": "8P",
        "airline_name": "Pacific Coastal Airlines"
    },
    {
        "airline_key": "PK",
        "airline_name": "Pakistan International Airline"
    },
    {
        "airline_key": "PB",
        "airline_name": "PAL Airlines"
    },
    {
        "airline_key": "2P",
        "airline_name": "Pal Express"
    },
    {
        "airline_key": "0P",
        "airline_name": "Palau Asia Pacific Air"
    },
    {
        "airline_key": "4L",
        "airline_name": "Palau National Airlines"
    },
    {
        "airline_key": "7N",
        "airline_name": "Pan AM World Airways Dominicana"
    },
    {
        "airline_key": "8A",
        "airline_name": "Panama Airways"
    },
    {
        "airline_key": "HI",
        "airline_name": "Papillon Airways"
    },
    {
        "airline_key": "ZP",
        "airline_name": "Paranair"
    },
    {
        "airline_key": "P6",
        "airline_name": "Pascan Aviation Inc"
    },
    {
        "airline_key": "P3",
        "airline_name": "Passaredo"
    },
    {
        "airline_key": "2Z",
        "airline_name": "Passaredo Transportes"
    },
    {
        "airline_key": "MM",
        "airline_name": "Peach Aviation"
    },
    {
        "airline_key": "EO",
        "airline_name": "Pegas Fly"
    },
    {
        "airline_key": "PC",
        "airline_name": "Pegasus Airlines"
    },
    {
        "airline_key": "FP",
        "airline_name": "Pelican Airlines"
    },
    {
        "airline_key": "KS",
        "airline_name": "Penair"
    },
    {
        "airline_key": "PE",
        "airline_name": "Peoples Viennaline"
    },
    {
        "airline_key": "YP",
        "airline_name": "Perimeter Aviation"
    },
    {
        "airline_key": "P9",
        "airline_name": "Peruvian Air Line"
    },
    {
        "airline_key": "UF",
        "airline_name": "Petroleum Air Services"
    },
    {
        "airline_key": "PR",
        "airline_name": "Philippine Airlines"
    },
    {
        "airline_key": "Z2",
        "airline_name": "Philippines Airasia"
    },
    {
        "airline_key": "1O",
        "airline_name": "Phoenix Systems Dertours"
    },
    {
        "airline_key": "PT",
        "airline_name": "Piedmont Airlines"
    },
    {
        "airline_key": "3I",
        "airline_name": "Pison Airways Ltd"
    },
    {
        "airline_key": "PU",
        "airline_name": "Plus Ultra Lineas Aereas"
    },
    {
        "airline_key": "CG",
        "airline_name": "PNG Air"
    },
    {
        "airline_key": "DP",
        "airline_name": "Pobeda Airlines"
    },
    {
        "airline_key": "PI",
        "airline_name": "Polar Airlines"
    },
    {
        "airline_key": "PD",
        "airline_name": "Porter Airlines"
    },
    {
        "airline_key": "NI",
        "airline_name": "Portug\u00e1lia"
    },
    {
        "airline_key": "PW",
        "airline_name": "Precision Air"
    },
    {
        "airline_key": "0J",
        "airline_name": "Premium Jet Ag"
    },
    {
        "airline_key": "6F",
        "airline_name": "Primera Air Nordic"
    },
    {
        "airline_key": "PF",
        "airline_name": "Primera Air Scandinavia"
    },
    {
        "airline_key": "P0",
        "airline_name": "Proflight Commuter"
    },
    {
        "airline_key": "OH",
        "airline_name": "PSA Airlines"
    },
    {
        "airline_key": "QZ",
        "airline_name": "PT Indonesia AirAsia"
    },
    {
        "airline_key": "KD",
        "airline_name": "Pt Kal Star Aviation"
    },
    {
        "airline_key": "SJ",
        "airline_name": "PT Sriwijaya Air"
    },
    {
        "airline_key": "IW",
        "airline_name": "Pt Wings Abadi Airlines"
    },
    {
        "airline_key": "IL",
        "airline_name": "Pt.Trigana Air Service"
    },
    {
        "airline_key": "P1",
        "airline_name": "PublicCharters.com"
    },
    {
        "airline_key": "ZR",
        "airline_name": "Punto Azul"
    },
    {
        "airline_key": "QF",
        "airline_name": "Qantas Airways"
    },
    {
        "airline_key": "QR",
        "airline_name": "Qatar Airways"
    },
    {
        "airline_key": "IQ",
        "airline_name": "Qazaq Air"
    },
    {
        "airline_key": "QB",
        "airline_name": "Qeshm Air"
    },
    {
        "airline_key": "QW",
        "airline_name": "Qingdao Airlines"
    },
    {
        "airline_key": "QO",
        "airline_name": "Quantum Air"
    },
    {
        "airline_key": "Q0",
        "airline_name": "Quebecair Express"
    },
    {
        "airline_key": "1D",
        "airline_name": "Raddix Solutions Intl"
    },
    {
        "airline_key": "RI",
        "airline_name": "Rahila Air"
    },
    {
        "airline_key": "7H",
        "airline_name": "Ravn Alaska"
    },
    {
        "airline_key": "WZ",
        "airline_name": "Red Wings Airlines"
    },
    {
        "airline_key": "2O",
        "airline_name": "Redemption"
    },
    {
        "airline_key": "RX",
        "airline_name": "Regent Airways"
    },
    {
        "airline_key": "8N",
        "airline_name": "Regional Air Services"
    },
    {
        "airline_key": "ZL",
        "airline_name": "Regional Express"
    },
    {
        "airline_key": "EX",
        "airline_name": "Regional Express Americas"
    },
    {
        "airline_key": "EE",
        "airline_name": "Regional Jet"
    },
    {
        "airline_key": "4P",
        "airline_name": "Regional Sky"
    },
    {
        "airline_key": "R4",
        "airline_name": "Reliable Unique Services"
    },
    {
        "airline_key": "4R",
        "airline_name": "Renfe Viajeros"
    },
    {
        "airline_key": "YX",
        "airline_name": "Republic Airline"
    },
    {
        "airline_key": "RH",
        "airline_name": "Robin Hood Aviation"
    },
    {
        "airline_key": "WQ",
        "airline_name": "Romavia"
    },
    {
        "airline_key": "FV",
        "airline_name": "Rossiya Airlines"
    },
    {
        "airline_key": "RG",
        "airline_name": "Rotana Jet"
    },
    {
        "airline_key": "RW",
        "airline_name": "Royal Air Charter Service"
    },
    {
        "airline_key": "RR",
        "airline_name": "Royal Air Force"
    },
    {
        "airline_key": "AT",
        "airline_name": "Royal Air Maroc"
    },
    {
        "airline_key": "BI",
        "airline_name": "Royal Brunei"
    },
    {
        "airline_key": "RL",
        "airline_name": "Royal Falcon"
    },
    {
        "airline_key": "RJ",
        "airline_name": "Royal Jordanian"
    },
    {
        "airline_key": "DR",
        "airline_name": "Ruili Airlines"
    },
    {
        "airline_key": "7R",
        "airline_name": "Rusline"
    },
    {
        "airline_key": "WB",
        "airline_name": "Rwandair"
    },
    {
        "airline_key": "FR",
        "airline_name": "Ryanair"
    },
    {
        "airline_key": "RK",
        "airline_name": "Ryanair Uk"
    },
    {
        "airline_key": "4Z",
        "airline_name": "Sa Airlink"
    },
    {
        "airline_key": "1W",
        "airline_name": "Sabre"
    },
    {
        "airline_key": "FA",
        "airline_name": "Safair"
    },
    {
        "airline_key": "F2",
        "airline_name": "Safarilink Aviation"
    },
    {
        "airline_key": "HN",
        "airline_name": "Saffat Airlines"
    },
    {
        "airline_key": "4Q",
        "airline_name": "Safi Airways"
    },
    {
        "airline_key": "PV",
        "airline_name": "Saint Barth Commuter"
    },
    {
        "airline_key": "OU",
        "airline_name": "Salam Air"
    },
    {
        "airline_key": "OL",
        "airline_name": "Samoa Airways"
    },
    {
        "airline_key": "RZ",
        "airline_name": "Sansa"
    },
    {
        "airline_key": "S3",
        "airline_name": "Santa Barbara Airlines"
    },
    {
        "airline_key": "6W",
        "airline_name": "Saratov Airlines"
    },
    {
        "airline_key": "SP",
        "airline_name": "SATA Air Acores"
    },
    {
        "airline_key": "S4",
        "airline_name": "SATA Azores Airlines"
    },
    {
        "airline_key": "9R",
        "airline_name": "Satena"
    },
    {
        "airline_key": "6S",
        "airline_name": "Saudi Gulf Airlines"
    },
    {
        "airline_key": "SV",
        "airline_name": "Saudia"
    },
    {
        "airline_key": "W7",
        "airline_name": "Sayakhat Airlines"
    },
    {
        "airline_key": "SK",
        "airline_name": "Scandinavian Airlines (SAS)"
    },
    {
        "airline_key": "YR",
        "airline_name": "Scenic Airlines"
    },
    {
        "airline_key": "TR",
        "airline_name": "Scoot"
    },
    {
        "airline_key": "CB",
        "airline_name": "Scotairways"
    },
    {
        "airline_key": "I4",
        "airline_name": "Scott Air"
    },
    {
        "airline_key": "BB",
        "airline_name": "Seaborne Airlines"
    },
    {
        "airline_key": "XO",
        "airline_name": "SEAir"
    },

    {
        "airline_key": "8D",
        "airline_name": "Servant Air"
    },
    {
        "airline_key": "5S",
        "airline_name": "Servicios Aereos Profesionales"
    },
    {
        "airline_key": "D2",
        "airline_name": "Severstal Aircompany"
    },
    {
        "airline_key": "NL",
        "airline_name": "Shaheen Air Intl"
    },
    {
        "airline_key": "SC",
        "airline_name": "Shandong Airlines"
    },
    {
        "airline_key": "FM",
        "airline_name": "Shanghai Airlines"
    },
    {
        "airline_key": "SH",
        "airline_name": "Sharp Aviation"
    },
    {
        "airline_key": "ZH",
        "airline_name": "Shenzhen Airlines"
    },
    {
        "airline_key": "8S",
        "airline_name": "Shun Tak China Turbojet"
    },
    {
        "airline_key": "O8",
        "airline_name": "Siam Air Transport"
    },
    {
        "airline_key": "5E",
        "airline_name": "Siam Ga"
    },
    {
        "airline_key": "KT",
        "airline_name": "Siavia"
    },
    {
        "airline_key": "S7",
        "airline_name": "Siberia Airlines"
    },
    {
        "airline_key": "3U",
        "airline_name": "Sichuan Airlines"
    },
    {
        "airline_key": "MI",
        "airline_name": "SilkAir"
    },
    {
        "airline_key": "3M",
        "airline_name": "Silver Airways Corp"
    },
    {
        "airline_key": "K5",
        "airline_name": "Silverstone Air Services Ltd"
    },
    {
        "airline_key": "SQ",
        "airline_name": "Singapore Airlines"
    },
    {
        "airline_key": "1M",
        "airline_name": "Sirena JSC"
    },
    {
        "airline_key": "1H",
        "airline_name": "Sirena-Travel"
    },
    {
        "airline_key": "XS",
        "airline_name": "Sita"
    },
    {
        "airline_key": "HK",
        "airline_name": "Skippers Aviation Pty"
    },
    {
        "airline_key": "H2",
        "airline_name": "Sky Airline"
    },
    {
        "airline_key": "H8",
        "airline_name": "Sky Airlines Peru"
    },
    {
        "airline_key": "ZA",
        "airline_name": "Sky Angkor Airlines"
    },
    {
        "airline_key": "GQ",
        "airline_name": "Sky Express"
    },
    {
        "airline_key": "DO",
        "airline_name": "Sky High Aviation Services"
    },
    {
        "airline_key": "DU",
        "airline_name": "Sky Jet M.G. Inc."
    },
    {
        "airline_key": "Y3",
        "airline_name": "Sky Kg Airlines"
    },
    {
        "airline_key": "UY",
        "airline_name": "Sky Prime Charter"
    },
    {
        "airline_key": "KV",
        "airline_name": "Sky Regional Airlines"
    },
    {
        "airline_key": "TE",
        "airline_name": "Sky Taxi"
    },
    {
        "airline_key": "Q7",
        "airline_name": "Skybahamas Airlines"
    },
    {
        "airline_key": "GW",
        "airline_name": "Skygreece Airlines"
    },
    {
        "airline_key": "M8",
        "airline_name": "Skyjet"
    },
    {
        "airline_key": "BC",
        "airline_name": "Skymark Airlines"
    },
    {
        "airline_key": "NB",
        "airline_name": "Skypower Express"
    },
    {
        "airline_key": "PQ",
        "airline_name": "Skyup Airlines"
    },
    {
        "airline_key": "OV",
        "airline_name": "Skyward Express"
    },
    {
        "airline_key": "OO",
        "airline_name": "SkyWest Airlines"
    },
    {
        "airline_key": "SX",
        "airline_name": "Skywork Airlines"
    },
    {
        "airline_key": "S5",
        "airline_name": "Small Planet"
    },
    {
        "airline_key": "P7",
        "airline_name": "Small Planet Airline (Ghd)"
    },
    {
        "airline_key": "5N",
        "airline_name": "Smartavia"
    },
    {
        "airline_key": "6Y",
        "airline_name": "Smartlynx Airlines"
    },
    {
        "airline_key": "QS",
        "airline_name": "Smartwings"
    },
    {
        "airline_key": "7O",
        "airline_name": "Smartwings Hungary"
    },
    {
        "airline_key": "2E",
        "airline_name": "Smokey Bay Air"
    },
    {
        "airline_key": "2C",
        "airline_name": "SNCF"
    },
    {
        "airline_key": "8R",
        "airline_name": "Sol L\u00edneas A\u00e9reas"
    },
    {
        "airline_key": "6J",
        "airline_name": "Solaseed Air"
    },
    {
        "airline_key": "IE",
        "airline_name": "Solomon Airlines"
    },
    {
        "airline_key": "S8",
        "airline_name": "Sounds Air"
    },
    {
        "airline_key": "SA",
        "airline_name": "South African Airways"
    },
    {
        "airline_key": "XZ",
        "airline_name": "South African Express"
    },
    {
        "airline_key": "YG",
        "airline_name": "South Airlines"
    },
    {
        "airline_key": "PL",
        "airline_name": "Southern Air Charter"
    },
    {
        "airline_key": "9X",
        "airline_name": "Southern Airways Express"
    },
    {
        "airline_key": "IH",
        "airline_name": "Southern Sky Airlines Jsc"
    },
    {
        "airline_key": "WN",
        "airline_name": "Southwest Airlines Texas"
    },
    {
        "airline_key": "5W",
        "airline_name": "Speed Alliance Westbahn"
    },
    {
        "airline_key": "SG",
        "airline_name": "SpiceJet"
    },
    {
        "airline_key": "NK",
        "airline_name": "Spirit Airlines"
    },
    {
        "airline_key": "9C",
        "airline_name": "Spring Airlines"
    },
    {
        "airline_key": "IJ",
        "airline_name": "Spring Airlines Japan"
    },
    {
        "airline_key": "P8",
        "airline_name": "SprintAir"
    },
    {
        "airline_key": "Q1",
        "airline_name": "Sqiva Sistem"
    },
    {
        "airline_key": "UL",
        "airline_name": "SriLankan Airlines"
    },
    {
        "airline_key": "0O",
        "airline_name": "Sta Travel"
    },
    {
        "airline_key": "4S",
        "airline_name": "Star Airways"
    },
    {
        "airline_key": "7G",
        "airline_name": "Star Flyer"
    },
    {
        "airline_key": "2I",
        "airline_name": "Star Peru"
    },
    {
        "airline_key": "S9",
        "airline_name": "Starbow"
    },
    {
        "airline_key": "JX",
        "airline_name": "STARLUX"
    },
    {
        "airline_key": "RE",
        "airline_name": "Stobart Air"
    },
    {
        "airline_key": "8F",
        "airline_name": "STP Airways"
    },
    {
        "airline_key": "SD",
        "airline_name": "Sudan Airways"
    },
    {
        "airline_key": "O7",
        "airline_name": "Sue Orenburg Region"
    },
    {
        "airline_key": "EZ",
        "airline_name": "Sun Air of Scandinavia"
    },
    {
        "airline_key": "SY",
        "airline_name": "Sun Country"
    },
    {
        "airline_key": "XQ",
        "airline_name": "Sun Express"
    },
    {
        "airline_key": "SR",
        "airline_name": "Sundair"
    },
    {
        "airline_key": "XG",
        "airline_name": "Sunexpress Germany"
    },
    {
        "airline_key": "S6",
        "airline_name": "Sunrise Airways"
    },
    {
        "airline_key": "WG",
        "airline_name": "Sunwing Airlines Inc."
    },
    {
        "airline_key": "Y8",
        "airline_name": "Suparna Airlines"
    },
    {
        "airline_key": "PY",
        "airline_name": "Surinam Airways"
    },
    {
        "airline_key": "1K",
        "airline_name": "Sutra Inc."
    },
    {
        "airline_key": "LZ",
        "airline_name": "Swiss Global Air Lines"
    },
    {
        "airline_key": "LX",
        "airline_name": "Swiss International Air Lines"
    },
    {
        "airline_key": "WO",
        "airline_name": "Swoop"
    },
    {
        "airline_key": "7E",
        "airline_name": "Sylt Air GmbH"
    },
    {
        "airline_key": "FS",
        "airline_name": "Syphax Airlines SA"
    },
    {
        "airline_key": "RB",
        "airline_name": "Syrian Arab Airlines"
    },
    {
        "airline_key": "DT",
        "airline_name": "Taag"
    },
    {
        "airline_key": "HH",
        "airline_name": "Taban Airlines"
    },
    {
        "airline_key": "TA",
        "airline_name": "Taca International Airlines"
    },
    {
        "airline_key": "VR",
        "airline_name": "Tacv Cabo Verde Airlines"
    },
    {
        "airline_key": "R9",
        "airline_name": "Taf Linhas Aereas"
    },
    {
        "airline_key": "7J",
        "airline_name": "Tajik Air"
    },
    {
        "airline_key": "EQ",
        "airline_name": "Tame Linea Aerea Del Ecuador"
    },
    {
        "airline_key": "QT",
        "airline_name": "Tampa Cargo"
    },
    {
        "airline_key": "4E",
        "airline_name": "Tanana Air Service"
    },
    {
        "airline_key": "TQ",
        "airline_name": "Tandem Aero"
    },
    {
        "airline_key": "R0",
        "airline_name": "Tantalus Air"
    },
    {
        "airline_key": "TP",
        "airline_name": "Tap Air Portugal"
    },
    {
        "airline_key": "K3",
        "airline_name": "Taquan Air Services"
    },
    {
        "airline_key": "3T",
        "airline_name": "Tarco Air"
    },
    {
        "airline_key": "RO",
        "airline_name": "TAROM"
    },
    {
        "airline_key": "H7",
        "airline_name": "Taron Avia"
    },
    {
        "airline_key": "SF",
        "airline_name": "Tassili Airlines"
    },
    {
        "airline_key": "U9",
        "airline_name": "Tatarstan Air"
    },
    {
        "airline_key": "OT",
        "airline_name": "Tchadia Airlines"
    },
    {
        "airline_key": "C1",
        "airline_name": "Tectimes Sudamerica"
    },
    {
        "airline_key": "FD",
        "airline_name": "Thai AirAsia"
    },
    {
        "airline_key": "XJ",
        "airline_name": "Thai Airasia X Company"
    },
    {
        "airline_key": "TG",
        "airline_name": "Thai Airways International"
    },
    {
        "airline_key": "SL",
        "airline_name": "Thai Lion Mentari"
    },
    {
        "airline_key": "WE",
        "airline_name": "Thai Smile Airways"
    },
    {
        "airline_key": "VZ",
        "airline_name": "Thai VietJet Air"
    },
    {
        "airline_key": "2H",
        "airline_name": "Thalys International"
    },
    {
        "airline_key": "MT",
        "airline_name": "Thomas Cook Airlines"
    },
    {
        "airline_key": "DK",
        "airline_name": "Thomas Cook Airlines A/S"
    },
    {
        "airline_key": "HQ",
        "airline_name": "Thomas Cook Airlines Belgium"
    },
    {
        "airline_key": "GS",
        "airline_name": "Tianjin Airlines"
    },
    {
        "airline_key": "3P",
        "airline_name": "Tiara Air Aruba"
    },
    {
        "airline_key": "TV",
        "airline_name": "Tibet Airlines"
    },
    {
        "airline_key": "TT",
        "airline_name": "Tiger Airways Australia"
    },
    {
        "airline_key": "IT",
        "airline_name": "Tigerair Taiwan"
    },
    {
        "airline_key": "ZT",
        "airline_name": "Titan Airways"
    },
    {
        "airline_key": "FF",
        "airline_name": "Tower Air Inc"
    },
    {
        "airline_key": "C3",
        "airline_name": "Trade Air"
    },
    {
        "airline_key": "TJ",
        "airline_name": "Tradewind Aviation"
    },
    {
        "airline_key": "GD",
        "airline_name": "Trans Aereos Ejecutivos"
    },
    {
        "airline_key": "T8",
        "airline_name": "Trans African Airlines"
    },
    {
        "airline_key": "Q8",
        "airline_name": "Trans Air Congo"
    },
    {
        "airline_key": "AX",
        "airline_name": "Trans States Airlines"
    },
    {
        "airline_key": "UN",
        "airline_name": "Transaero Airlines"
    },
    {
        "airline_key": "GE",
        "airline_name": "Transasia Airways"
    },
    {
        "airline_key": "HV",
        "airline_name": "Transavia Airlines"
    },
    {
        "airline_key": "PH",
        "airline_name": "Transavia Denmark"
    },
    {
        "airline_key": "TO",
        "airline_name": "Transavia France"
    },
    {
        "airline_key": "8B",
        "airline_name": "Transnusa Aviation"
    },
    {
        "airline_key": "5U",
        "airline_name": "Transportes Aereos"
    },
    {
        "airline_key": "XN",
        "airline_name": "Travel Express Aviation"
    },
    {
        "airline_key": "3Z",
        "airline_name": "Travel Service Polska"
    },
    {
        "airline_key": "6D",
        "airline_name": "Travel Service Slovensko"
    },
    {
        "airline_key": "Y1",
        "airline_name": "Travel Technology Interactive"
    },
    {
        "airline_key": "1G",
        "airline_name": "Travelport"
    },
    {
        "airline_key": "1E",
        "airline_name": "Travelsky Technology Ltd"
    },
    {
        "airline_key": "7T",
        "airline_name": "Trenitalia"
    },
    {
        "airline_key": "T4",
        "airline_name": "Trip"
    },
    {
        "airline_key": "9N",
        "airline_name": "Tropic Air Limited"
    },
    {
        "airline_key": "TI",
        "airline_name": "Tropic Oceanairways"
    },
    {
        "airline_key": "TZ",
        "airline_name": "Tsaradia"
    },
    {
        "airline_key": "BY",
        "airline_name": "Tui"
    },
    {
        "airline_key": "TB",
        "airline_name": "TUI Fly Belgium"
    },
    {
        "airline_key": "OR",
        "airline_name": "TUI fly Netherlands"
    },
    {
        "airline_key": "X3",
        "airline_name": "TUIfly"
    },
    {
        "airline_key": "6B",
        "airline_name": "TUIfly Nordic"
    },
    {
        "airline_key": "TU",
        "airline_name": "Tunisair"
    },
    {
        "airline_key": "UG",
        "airline_name": "Tunisair Express"
    },
    {
        "airline_key": "2T",
        "airline_name": "Turbo Megha Airways"
    },
    {
        "airline_key": "TK",
        "airline_name": "Turkish Airlines"
    },
    {
        "airline_key": "T5",
        "airline_name": "Turkmenistan Airlines"
    },
    {
        "airline_key": "T9",
        "airline_name": "Turpial Airlines"
    },
    {
        "airline_key": "U8",
        "airline_name": "Tus Airways"
    },
    {
        "airline_key": "TW",
        "airline_name": "Tway Air"
    },
    {
        "airline_key": "T7",
        "airline_name": "Twin Jet"
    },
    {
        "airline_key": "PS",
        "airline_name": "Ukraine International Airlines"
    },
    {
        "airline_key": "X5",
        "airline_name": "Uld Logistics Llc"
    },
    {
        "airline_key": "UE",
        "airline_name": "Ultimate Jetcharters"
    },
    {
        "airline_key": "TH",
        "airline_name": "undefined"
    },
    {
        "airline_key": "B7",
        "airline_name": "Uni Airways"
    },
    {
        "airline_key": "UA",
        "airline_name": "United Airlines"
    },
    {
        "airline_key": "4H",
        "airline_name": "United Airways Bangladesh"
    },
    {
        "airline_key": "UW",
        "airline_name": "Universal Airlines"
    },
    {
        "airline_key": "U6",
        "airline_name": "Ural Airlines"
    },
    {
        "airline_key": "UQ",
        "airline_name": "Urumqi Airlines"
    },
    {
        "airline_key": "US",
        "airline_name": "Us Airways"
    },
    {
        "airline_key": "BS",
        "airline_name": "US-Bangla Airlines Ltd."
    },
    {
        "airline_key": "UT",
        "airline_name": "Utair Aviation Jsc"
    },
    {
        "airline_key": "UR",
        "airline_name": "Utair Express"
    },
    {
        "airline_key": "HY",
        "airline_name": "Uzbekistan Airways"
    },
    {
        "airline_key": "ZV",
        "airline_name": "V Air"
    },
    {
        "airline_key": "V9",
        "airline_name": "Van Air Europe"
    },
    {
        "airline_key": "JW",
        "airline_name": "Vanilla Air"
    },
    {
        "airline_key": "V6",
        "airline_name": "Vi Air Link"
    },
    {
        "airline_key": "VC",
        "airline_name": "Via Airlines"
    },
    {
        "airline_key": "U1",
        "airline_name": "Videcom International"
    },
    {
        "airline_key": "V4",
        "airline_name": "Vieques Air"
    },
    {
        "airline_key": "VJ",
        "airline_name": "VietJet Aviation"
    },
    {
        "airline_key": "0V",
        "airline_name": "Vietnam Air Service"
    },
    {
        "airline_key": "VN",
        "airline_name": "Vietnam Airlines"
    },
    {
        "airline_key": "VP",
        "airline_name": "Villa Air"
    },
    {
        "airline_key": "NN",
        "airline_name": "Vim Airlines"
    },
    {
        "airline_key": "VX",
        "airline_name": "Virgin America"
    },
    {
        "airline_key": "VS",
        "airline_name": "Virgin Atlantic"
    },
    {
        "airline_key": "VA",
        "airline_name": "Virgin Australia"
    },
    {
        "airline_key": "V2",
        "airline_name": "Vision Airlines"
    },
    {
        "airline_key": "UK",
        "airline_name": "Vistara"
    },
    {
        "airline_key": "VV",
        "airline_name": "Viva Airlines Peru"
    },
    {
        "airline_key": "VH",
        "airline_name": "Viva Colombia"
    },
    {
        "airline_key": "XF",
        "airline_name": "Vladivostok Air"
    },
    {
        "airline_key": "VG",
        "airline_name": "Vlm Airlines"
    },
    {
        "airline_key": "VO",
        "airline_name": "Vlm Airlines D.D."
    },
    {
        "airline_key": "Y4",
        "airline_name": "Volaris"
    },
    {
        "airline_key": "Q6",
        "airline_name": "Volaris Costa Rica"
    },
    {
        "airline_key": "VI",
        "airline_name": "Volga Dnepr Airline"
    },
    {
        "airline_key": "V7",
        "airline_name": "Volotea"
    },
    {
        "airline_key": "VY",
        "airline_name": "Vueling Airlines"
    },
    {
        "airline_key": "VU",
        "airline_name": "Vuelos Economicos"
    },
    {
        "airline_key": "EB",
        "airline_name": "Wamos Air"
    },
    {
        "airline_key": "4W",
        "airline_name": "Warbelows Air Ventures"
    },
    {
        "airline_key": "WT",
        "airline_name": "Wasaya Airways"
    },
    {
        "airline_key": "Q9",
        "airline_name": "Wataniya Airways"
    },
    {
        "airline_key": "2W",
        "airline_name": "Welcome Air"
    },
    {
        "airline_key": "WH",
        "airline_name": "West African Airlines"
    },
    {
        "airline_key": "0W",
        "airline_name": "West Caribbean Costa Rica"
    },
    {
        "airline_key": "9L",
        "airline_name": "West Link Airways"
    },
    {
        "airline_key": "WV",
        "airline_name": "Westair Aviation"
    },
    {
        "airline_key": "WS",
        "airline_name": "WestJet"
    },
    {
        "airline_key": "WR",
        "airline_name": "Westjet Encore Ltd"
    },
    {
        "airline_key": "WI",
        "airline_name": "White Airways S.A."
    },
    {
        "airline_key": "WF",
        "airline_name": "Wider\u00f8e"
    },
    {
        "airline_key": "7W",
        "airline_name": "Wind Rose Aviation"
    },
    {
        "airline_key": "WM",
        "airline_name": "Windward Island Airways"
    },
    {
        "airline_key": "W6",
        "airline_name": "Wizz Air Hungary"
    },
    {
        "airline_key": "W9",
        "airline_name": "Wizz Air Uk"
    },
    {
        "airline_key": "W1",
        "airline_name": "World Ticket Ltd"
    },
    {
        "airline_key": "1P",
        "airline_name": "Worldspan"
    },
    {
        "airline_key": "WW",
        "airline_name": "Wow Air"
    },
    {
        "airline_key": "8V",
        "airline_name": "Wright Air Services"
    },
    {
        "airline_key": "MF",
        "airline_name": "Xiamen Airlines"
    },
    {
        "airline_key": "SE",
        "airline_name": "XL Airways France"
    },
    {
        "airline_key": "XP",
        "airline_name": "Xtra Airways"
    },
    {
        "airline_key": "YC",
        "airline_name": "Yamal Airlines"
    },
    {
        "airline_key": "YE",
        "airline_name": "Yan Air"
    },
    {
        "airline_key": "YH",
        "airline_name": "Yangon Airways"
    },
    {
        "airline_key": "Y0",
        "airline_name": "Yellow Airtaxi"
    },
    {
        "airline_key": "IY",
        "airline_name": "Yemen Airways"
    },
    {
        "airline_key": "YT",
        "airline_name": "Yeti Airlines"
    },
    {
        "airline_key": "Y2",
        "airline_name": "Ygnus Air"
    },
    {
        "airline_key": "A6",
        "airline_name": "Yunnan Hong Tu Airlines"
    },
    {
        "airline_key": "YI",
        "airline_name": "Yunnan Yingan Airline"
    },
    {
        "airline_key": "4Y",
        "airline_name": "Yute Air Alaska"
    },
    {
        "airline_key": "Z4",
        "airline_name": "Zagros Jet"
    },
    {
        "airline_key": "ZJ",
        "airline_name": "Zambezi Airlines"
    },
    {
        "airline_key": "B4",
        "airline_name": "ZanAir"
    },
    {
        "airline_key": "GJ",
        "airline_name": "Zhejiang Loong Airlines"
    },
     {
        "airline_key": "PA",
        "airline_name": "Airblue"
    },
    {
        "airline_key": "PF (PAK)",
        "airline_name": "Airsial"
    },
    {
        "airline_key": "9P (PAK)",
        "airline_name": "Fly Jinnah"
    },
    {
        "airline_key": "ER",
        "airline_name": "Serene Air"
    }
];


for $air in $airlines {
    create airline content {
        key: $air.airline_key,
        name: $air.airline_name,
    };
};

