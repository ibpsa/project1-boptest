import {getWorkerData} from './just-in-time-data.js';

export function getKPIs(id, redis) {
  return getWorkerData(id, "kpis", redis, {});
}
