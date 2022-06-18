import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();

const DB_RETRY_TIME = process.env.DB_RETRY_TIME || 2000;

// Variables de entorno para MongoDB 
const MONGODB_USER = process.env.MONGODB_USER || 'root';
const MONGODB_PASS = process.env.MONGODB_PASS || 'root';
const MONGODB_NAME = process.env.MONGODB_NAME || 'bases2';
const MONGODB_HOST = process.env.MONGODB_HOST || 'localhost';
const MONGODB_PORT = process.env.MONGODB_PORT || 27017;

// Seteando URL de conexion
const MONGODB_URL = `mongodb://${MONGODB_USER}:${MONGODB_PASS}@${MONGODB_HOST}:${MONGODB_PORT}/?authSource=admin&readPreference=primary&directConnection=true&ssl=false`;

let db = mongoose.connection;
let connectWithRetry = function () {
  return mongoose.connect(MONGODB_URL);
};

connectWithRetry();

function delay(ms: number) {
    return new Promise( resolve => setTimeout(resolve, ms) );
}

db.on('error', () => {
	setTimeout(() => {
		console.log('DB connection failed. Will try again.');
		connectWithRetry();
  }, Number(DB_RETRY_TIME));
});

async function activeDeamon(): Promise<void> {
    console.log("DEMONIO ACTIVADO - ", new Date().toLocaleString());
  }

db.on('connected', async function () {
    console.log('Mongo Connected');    
    while(true){          
          await activeDeamon()
          await delay(3000)
    }          
});