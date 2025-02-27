import { Request, Response, NextFunction } from 'express';
import logging from '../config/logging';
import mysql from '../controllers/db';
import bcrypt from 'bcrypt';

const NAMESPACE = 'Auth Controller';

// req : { username: string, password: string, passwordConfirm: string }
// success res : { message: string }, status 200
// failure res : { message: string }, status 400
const signup = (req: Request, res: Response) => {
    logging.info(NAMESPACE, 'Attempted signup');
    const { username, role, password, passwordConfirm } = req.body;

    mysql.db.query('SELECT username FROM account WHERE username = ?', [username], async (error, result) => {
        if (error) {
            logging.error(NAMESPACE, 'Could not query username', error);
        }
        if (result > 0) {
            logging.info(NAMESPACE, 'Username already in use');
            return res.status(400).json({
                message: 'Username already in use'
            });
        } else if (password !== passwordConfirm) {
            logging.info(NAMESPACE, 'Passwords do not match');
            return res.status(400).json({
                message: 'Passwords do not match'
            });
        }

        let salt = bcrypt.genSaltSync();
        let hashedPassword = await bcrypt.hash(password, salt);
        mysql.db.query('INSERT INTO account VALUES ?', [username, role, hashedPassword, salt],
        (error, result) => {
            if (error) {
                logging.info(NAMESPACE, 'Error inserting user into db', error);
            } else {
                logging.info(NAMESPACE, 'Sign up endpoint hit', result);
                return res.status(200).json({
                    message: 'User account created!',
                    result: result
                });
            }
        });
    });
};

// req : { username: string, password: string }
// success res : { message: string }, status 200
// failure res : { message: string }, status 400
const login = (req: Request, res: Response) => {
    logging.info(NAMESPACE, 'Attempted login');
    try {
        const { username, password } = req.body;
        if (!username || !password) {
            return res.status(400).json({
                message: 'Please provide an username or password'
            });
        }

        mysql.db.query('SELECT * FROM account WHERE username = ?', [username],
        async (error, result) => {
            if (!result || !(await bcrypt.compare(password, result[0].password))) {
                res.status(400).json({
                    message: 'Username or password is incorrect'
                });
            } else {
                res.status(200).json({
                    message: 'Successfully logged in'
                });
            }
        });
    } catch (error) {
        logging.error(NAMESPACE, 'Error during login', error);
    }
};

export default {
    signup,
    login
};
