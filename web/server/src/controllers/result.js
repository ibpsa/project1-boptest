import {getWorkerData} from '../controllers/just-in-time-data.js';

export function getResults(id, point_name, start_time, final_time, redis) {
  const params = {point_name, start_time, final_time}
  return getWorkerData(id, "results", redis, params);
}
