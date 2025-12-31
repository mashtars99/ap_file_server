

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

