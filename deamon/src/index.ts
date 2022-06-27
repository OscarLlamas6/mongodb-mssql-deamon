import mongoose from 'mongoose';
import sql from "mssql";
import dotenv from 'dotenv';
const Schema = mongoose.Schema
dotenv.config();

const DB_RETRY_TIME = process.env.DB_RETRY_TIME || 2000;

// Variables de entorno para MongoDB 
const MONGODB_USER = process.env.MONGODB_USER || 'root';
const MONGODB_PASS = process.env.MONGODB_PASS || 'root';
const MONGODB_NAME = process.env.MONGODB_NAME || 'bases2';
const MONGODB_HOST = process.env.MONGODB_HOST || 'localhost';
const MONGODB_PORT = process.env.MONGODB_PORT || 27017;

// Variables de entorno para MSSQL Server

const MSSQLSV_USER = process.env.MSSQLSV_USER || 'sa';
const MSSQLSV_PASS = process.env.MSSQLSV_PASS || 'root';
const MSSQLSV_NAME = process.env.MSSQLSV_NAME || 'database';
const MSSQLSV_HOST = process.env.MSSQLSV_HOST || 'localhost';

// Seteando URL de conexion
const MONGODB_URL = `mongodb://${MONGODB_USER}:${MONGODB_PASS}@${MONGODB_HOST}:${MONGODB_PORT}/${MONGODB_NAME}?authSource=admin&readPreference=primary&directConnection=true&ssl=false`;

export const msSQLSettings = {
    user: MSSQLSV_USER,
    password: MSSQLSV_PASS,
    server: MSSQLSV_HOST,
    database: MSSQLSV_NAME,
    options: {
      encrypt: false, // for azure
      trustServerCertificate: true, // change to true for local dev / self-signed certs
    },
  };

let contador = 0;
let deamondActive = false;

async function startDeamon(){
    while(true){          
        deamondActive = true;
        await activeDeamon()
        //console.log(contador)
        await delay(10000)
    }  
}      

let mongoDBAttempts: number = 0;
let MSSQLAttempts: number = 0;

// Funcion para conectar a MongoDB con retry si se desconecta
let mongoConn = mongoose.connection;
let connectMongoWithRetry = async function () {
   
    await mongoose.connect(MONGODB_URL);

   // Si hay un error de conexion a Mongo reintentar
   
};

mongoConn.on('error', async () => {
    mongoDBAttempts++;
    if(mongoDBAttempts<=10 && deamondActive){
        setTimeout( async () => {
            console.log('MongoDB connection failed. Will try again.');
            await connectMongoWithRetry();
      }, Number(DB_RETRY_TIME));
    } else {
        throw new Error('MongoDB connection failed after 10 attempts. Exit program.');
    }
});


// Funcion para conectar a MSSQL con retry si se desconecta
let mssqlConn = new sql.ConnectionPool(msSQLSettings);
let connectMSSQLWithRetry = async function () {
    
    await mssqlConn.connect();

    

}

mssqlConn.on('error', async () => {
    MSSQLAttempts++;
    if(MSSQLAttempts<=10 && deamondActive){
        setTimeout( async () => {
            console.log('MSSQL SV DB connection failed. Will try again.');
            await connectMSSQLWithRetry();
      }, Number(DB_RETRY_TIME));
    } else {
        throw new Error('MSSQL SV DB connection failed after 10 attempts. Exit program.');
    }       
});

function delay(ms: number) {
    return new Promise( resolve => setTimeout(resolve, ms) );
}

async function activeDeamon(): Promise<void> {

    try {

        console.log("DEMONIO ACTIVADO - ", new Date().toLocaleString());

        // Conectando a MongoDB
        await connectMongoWithRetry();
        let netflixSchema = new Schema({}, { strict: false, collection: "netflix" });
        let Netflix =  mongoose.models.Netflix || mongoose.model('Netflix', netflixSchema);
        // Conectando a MSSQL
        await connectMSSQLWithRetry();

        // Revisando conexion a MongoDB
        console.log("Estado MongoDB: ", mongoose.STATES[mongoose.connection.readyState])

        // Revisando conexion a MSSQL
        let MSSQLstatus = mssqlConn.connected ? "connected" : "disconnected";
        console.log("Estado MSSQL: ", MSSQLstatus);
       
        // LOGIC
        const results = await mssqlConn.request()
            .execute(`GetAllData`);
        
        //let newResults:any[] = [];

        
        for (let i = 0; i < results.rowsAffected[0]; i++) {
            //newResults.push(results.recordset[i]);       

            const options = {
                upsert: true,
                new: true,
                runValidators: true,
                setDefaultsOnInsert: true,
                rawResult: true,
            };

            try {
                const mongoResult = await Netflix.findOneAndUpdate({ id: results.recordset[i].id }, results.recordset[i], options);
                if(mongoResult.lastErrorObject.upserted){
                    console.log("Registro creado en MongoDB exitosamente :D");
                }
            } catch (error) {
                console.log("Error al crear registro en MongoDB :(");
            }

            
        }

        //console.log(newResults)
        // -----------------------------------------------------------------------------
        
        // Closing mongoDB conn
        await mongoConn.close()
        await mongoose.disconnect();
        console.log("Estado MongoDB: ", mongoose.STATES[mongoose.connection.readyState]);
        // Revisando conexion a MSSQL
        await mssqlConn.close();
        MSSQLstatus = mssqlConn.connected ? "connected" : "disconnected";
        console.log("Estado MSSQL: ", MSSQLstatus);
        
    } catch (error) {
        console.log('Unexpected error: ',error);
    }

}

startDeamon()





