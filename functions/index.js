const functions = require('firebase-functions');
const request = require("request");

const apiKey = "785199eade3c1a2c21822c245c4b2986"
// const checkingAccount = "5d731182322fa016762f2fae"
// const sparechangeAccount = "5d73258b3c8c2216c9fcac3e"

// Transfers the rounded up money from your checking/credit/etc to sparechangeAccount
exports.transferRoundedMoney = functions.https.onCall((data, context) => {
    return new Promise(function (resolve, reject) {
        var spending = data.spending
        var checkingAccount = data.checkingAccount
        var sparechangeAccount = data.sparechangeAccount

        var roundedValue = Math.ceil(spending)
        var valueToTransfer = roundedValue - spending
        var options = {
            method: 'POST',
            url: 'http://api.reimaginebanking.com/accounts/' + checkingAccount + '/transfers',
            qs: { key: apiKey },
            body: {
                medium: 'balance',
                payee_id: sparechangeAccount,
                amount: valueToTransfer
            },
            json: true
        };
        request(options, function (error, response, body) {
            if (error) {
                reject(error);
            }
            else {
                resolve(body)
            }
        });
    });
});

exports.donateMoney = functions.https.onCall((data, context) => {
    return new Promise(function (resolve, reject) {
        var donateamount = data.donation
        var sparechangeAccount = data.sparechangeAccount

        var options = {
            method: 'POST',
            url: 'http://api.reimaginebanking.com/accounts/' + sparechangeAccount + '/withdrawals',
            qs: { key: apiKey },
            body: {
                medium: 'balance',
                amount: Math.abs(donateamount)
            },
            json: true
        };
        request(options, function (error, response, body) {
            if (error) {
                reject(error);
            }
            else {
                resolve(body)
            }
        });
    });
});

exports.viewBalanceSparechange = functions.https.onCall((data, context) => {
    sparechangeAccount = data.sparechangeAccount
    return new Promise(function (resolve, reject) {
        var options = { 
            method: 'GET',
            url: 'http://api.reimaginebanking.com/accounts/' + sparechangeAccount,
            qs: { key: apiKey }
        }   
        request(options, function (error, response, body) {
            if (error) {
                reject(error);
            }
            else {
                resolve(body)
            }
        })
    })
})

exports.getAccountHistory = functions.https.onCall((data,context) =>{
    sparechangeAccount = data.sparechangeAccount
    return new Promise(function (resolve, reject) {
        var options = {
            method: 'GET',
            url: 'http://api.reimaginebanking.com/accounts/' + sparechangeAccount + '/withdrawals',
            qs: { key: apiKey }
        }
        request(options, function (error, response, body) {
            if (error) {
                reject(error);
            }
            else {
                resolve(body)
            }
        })
    })
})

exports.getDonationHistory = functions.https.onCall((data, context) => {
    sparechangeAccount = data.sparechangeAccount
    return new Promise(function (resolve, reject) {
        var options = {
            method: 'GET',
            url: 'http://api.reimaginebanking.com/accounts/' + sparechangeAccount + '/withdrawals',
            qs: { key: apiKey }
        }
        request(options, function (error, response, body) {
            if (error) {
                reject(error);
            }
            else {
                resolve(body)
            }
        })
    })
})