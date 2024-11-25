sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'mycapmfiori/test/integration/FirstJourney',
		'mycapmfiori/test/integration/pages/purchaseorderList',
		'mycapmfiori/test/integration/pages/purchaseorderObjectPage',
		'mycapmfiori/test/integration/pages/poitemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, purchaseorderList, purchaseorderObjectPage, poitemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('mycapmfiori') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThepurchaseorderList: purchaseorderList,
					onThepurchaseorderObjectPage: purchaseorderObjectPage,
					onThepoitemsObjectPage: poitemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);