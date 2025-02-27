import { Request, Response, NextFunction } from 'express';
import logging from '../config/logging';
import mysql from './db';

const NAMESPACE = 'Patient Controller';

// req : {}
// res : { result: DataRowPackets }
const getAll = (req: Request, res: Response) => {
    logging.info(NAMESPACE, `getAll endpoint called.`);
    mysql.db.query('SELECT * FROM patient', (error, result) => {
        if (error) {
            logging.error(NAMESPACE, 'Could not perform query', error);
            res.status(400).json(error);
        } else {
            return res.status(200).json({
                result: result
            });
        }
    });
};

// req : { id: int }
// res : { result }
const getPatient = (req: Request, res: Response) => {
    logging.info(NAMESPACE, `getPatientDoctor called.`);

    mysql.db.query('SELECT * FROM patient WHERE patientId = ?', [req.body['id']],
    (error, result) => {
        if (error) {
            logging.error(NAMESPACE, 'Could not perform query', error);
            res.status(400).json(error);
        } else {
            return res.status(200).json({
                result: result
            });
        }
    });
};

const postPatient = (req: Request, res: Response) => {
    logging.info(NAMESPACE, `postDoctor called.`);
    let { ssn, firstName, lastName, phone, streetName, streetNumber, city, zip, insurance } = req.body;

    mysql.db.query('INSERT INTO patient VALUES ?', [ssn, firstName, lastName, phone, streetName, streetNumber, city, zip, insurance],
     (error, result) => {
        if (error) {
            logging.error(NAMESPACE, 'Could not perform query', error);
            res.status(400).json(error);
        } else {
            return res.status(200).json({
                result: result
            });
        }
    });
};

const updatePatient = (req: Request, res: Response) => {
    logging.info(NAMESPACE, `updatePatient endpoint called.`);
    mysql.db.query('REPLACE', [req.body['id']], (error, result) => {
        if (error) {
            logging.error(NAMESPACE, 'Could not perform query', error);
            res.status(400).json(error);
        } else {
            return res.status(200).json({
                result: result
            });
        }
    });
};

export default {
    getAll,
    getPatient,
    postPatient,
    updatePatient
};
