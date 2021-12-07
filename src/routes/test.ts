import express from 'express';
import controller from '../controllers/test';

const router = express.Router();

router.get('/', controller.getAll);
router.get('/id', controller.getTest);
router.post('/', controller.postTest);
router.put('/', controller.updateTest);

export = router;
