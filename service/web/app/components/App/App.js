/***********************************************************************************************************************
*  Copyright (c) 2008-2018, Alliance for Sustainable Energy, LLC, and other contributors. All rights reserved.
*
*  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
*  following conditions are met:
*
*  (1) Redistributions of source code must retain the above copyright notice, this list of conditions and the following
*  disclaimer.
*
*  (2) Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
*  disclaimer in the documentation and/or other materials provided with the distribution.
*
*  (3) Neither the name of the copyright holder nor the names of any contributors may be used to endorse or promote products
*  derived from this software without specific prior written permission from the respective party.
*
*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) AND ANY CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
*  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
*  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S), ANY CONTRIBUTORS, THE UNITED STATES GOVERNMENT, OR THE UNITED
*  STATES DEPARTMENT OF ENERGY, NOR ANY OF THEIR EMPLOYEES, BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
*  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
*  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
*  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
*  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
***********************************************************************************************************************/

import React from 'react';
import PropTypes from 'prop-types';
import { Component } from 'react';
import { Link, Route, Switch } from 'react-router-dom';
import IconButton from '@material-ui/core/IconButton';
import {FileCloudQueue, FileCloudDone, ActionAccountCircle} from '@material-ui/icons';
import { MuiPickersUtilsProvider } from '@material-ui/pickers';
import MomentUtils from '@date-io/moment';
import Toolbar from '@material-ui/core/Toolbar';
import AppBar from '@material-ui/core/AppBar';
import Badge from '@material-ui/core/Badge';
import Upload from '../Upload/Upload.js';
import Sites from '../Sites/Sites.js';
import Sims from '../Sims/Sims.js';
import Typography from '@material-ui/core/Typography';
import { withStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';

const styles = theme => ({
  root: {
    display: 'flex',
    flexDirection: 'column',
    minHeight: '100vh',
  },
  title: {
    flex: 1,
  },
  button: {
    margin: theme.spacing(1),
  },
});

class App extends React.Component {
  render = () => {
    const { classes } = this.props;

    return (
        <MuiPickersUtilsProvider utils={MomentUtils}>
          <div className={this.props.classes.root}>
            <AppBar position="static">
              <Toolbar>
                <Link to={'/'} className={this.props.classes.title} style={{ textDecoration: 'none', color: 'unset' }}> 
                  <Typography variant="h5" color="inherit">BOPTEST</Typography>
                </Link>
                <Grid container justify='flex-end'>
                  <Grid item>
                    <Link to={'/sites'} style={{ textDecoration: 'none', color: 'unset' }}>
                      <Typography className={classes.button} variant="button" color="inherit">Test-Cases</Typography>
                    </Link>
                  </Grid>
                  <Grid item>
                    <Link to={'/sims'} style={{ textDecoration: 'none', color: 'unset' }}>
                      <Typography className={classes.button} variant="button" color="inherit">Completed-Tests</Typography>
                    </Link>
                  </Grid>
                </Grid>
              </Toolbar>
            </AppBar>
            <Switch>
              <Route path="/sites" component={Sites}/>
              <Route path="/sims" component={Sims}/>
              <Route component={Upload}/>
            </Switch>       
          </div>
        </MuiPickersUtilsProvider>
    );
  }
};

App.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(App);

