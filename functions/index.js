/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const admin = require("firebase-admin");
//const auth = require("firebase-auth");
const functions = require("firebase-functions");

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

var serviceAccount = require("./do-it-efe08-firebase-adminsdk-ggkfj-fbf4aed76e.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

exports.createCustomToken = onRequest(async (request, response) => {
  //logger.info("Hello logs!", {structuredData: true});
  //response.send("Hello from Firebase!");
    const user = request.body;

    const uid = `kakao:${user.uid}`;
    const updateParams = {
        photoURL: user.photoURL,
        displayName: user.displayName,
    };

    try {
      await admin.auth().updateUser(uid, updateParams); // 바뀌면 업데이트
    } catch(e) { // 등록이 안되어있으면 id넣어서 create
        updateParams["uid"] = uid;
        await admin.auth().createUser(updateParams);
    }
    const token = await admin.auth().createCustomToken(uid);  // Firebase에 uid로 등록된 사용자의 토큰을 만들어줌

    response.send(token); // 토큰 돌려주기
});
