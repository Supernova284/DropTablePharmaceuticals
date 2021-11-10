import express from 'express';
import controller from '../controllers/get';

const router = express.Router();

router.get('/doctor', controller.getDoctor);

export = router;
