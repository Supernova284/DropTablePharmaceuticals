import { Request, Response, NextFunction } from 'express';
import logging from '../config/logging';
import mysql from '../controllers/db';

const NAMESPACE = 'GET Controller';

// req : {}
// res : { result: DataRowPackets }
const getDoctor = (req: Request, res: Response, next: NextFunction) => {
    logging.info(NAMESPACE, `Doctor endpoint called.`);
    console.log(req.body);
    // figure out best way to parse incoming queries
    // or just make custom routes for them?
    mysql.db.query('SELECT * FROM doctor', (error, result) => {
        if (error) {
            logging.error(NAMESPACE, 'Could not perform query', error);
        } else {
            return res.status(200).json({
                result: result
            });
        }
    });
};

export default {
    getDoctor
};
