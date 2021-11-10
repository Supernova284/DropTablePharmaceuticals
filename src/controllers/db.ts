import { Request, Response, NextFunction } from 'express';
import logging from '../config/logging';
import config from '../config/config';
import mysql from 'mysql';

const db = mysql.createConnection(config.mysql);

db.connect((error: Error) => {
    if (error) {
        console.log(error);
    } else {
        console.log('MySQL connected!');
    }
});

export default {
    db
};
