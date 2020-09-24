import express from 'express';
import got from 'got'
const boptestRoutes = express.Router();

// Make a graphql query to the server
const graphqlPost = async (querystring, req, res) => {
  try {
    const {body} = await got.post( req.protocol + '://' + req.get('host') + '/graphql', {
      json: {
        query: querystring
      }
    });
    res.send(body);
  } catch (error) {
    res.next(error);
  }
};

// Wait for the specified condition
const wait = (id, condition) => {
  querystring = `{ viewer{ sites(siteRef: "${id}") { simStatus } } }`;

  try {
    const body = graphqlPost(querystring, req, res);
    const simStatus = j["data"]["viewer"]["sites"][0]["simStatus"];
  } catch {
  }
};

boptestRoutes.post('/advance/:id', (req, res) => {
  const querystring = `mutation { advance(siteRefs: "${req.params.id}") }`;

  graphqlPost(querystring, req, res); 
});

boptestRoutes.post('/initialize/:id', (req, res) => {
  const querystring = `mutation{
    runSite(
      siteRef: "${req.params.id}",
      startDatetime: "0",
      endDatetime: "86400",
      externalClock: true,
    	timescale: 1.0
    )
  }`;

  graphqlPost(querystring, req, res); 
});

export default boptestRoutes;

