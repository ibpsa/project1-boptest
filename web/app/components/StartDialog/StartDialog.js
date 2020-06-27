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

import React, { PropTypes } from 'react';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';
import { DateTimePicker } from '@material-ui/pickers';
import { withStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Switch from '@material-ui/core/Switch';
import * as moment from 'moment';

const styles = theme => ({
  label: {
   whiteSpace: 'nowrap' 
  },
  button: {
    margin: theme.spacing(1),
  },
});

class StartDialog extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      open: false,
      realtime: false,
      externalClock: false,
      timescale: 5,
      selectedStartSeconds: 0,
      selectedEndSeconds: 86400,
    };
  }

  componentWillMount = () => {
    console.log(this.props);
    this.state.selectedStartSeconds = 0;
    this.state.selectedEndSeconds = 86400;
  }

  handleTimescaleChange = event => {
    this.setState({ timescale: Number(event.target.value) })
  }

  handleStartSecondChange = event => {
    this.setState({ selectedStartSeconds: event.target.value })
  }

  handleEndSecondChange = event => {
    this.setState({ selectedEndSeconds: event.target.value })
  }

  handleShowDialogClick = () => {
    this.setState({open: true});
  }

  handleRequestClose = () => {
    this.setState({open: false});
  }

  handleRequestStart = () => {
    this.props.onStartSimulation(this.state.selectedStartSeconds.toString(),this.state.selectedEndSeconds.toString(),this.state.timescale,this.state.realtime,this.state.externalClock);
    this.setState({open: false});
  }

  render = () => {
    const { selectedStartTime, selectedEndTime, selectedStartSeconds, selectedEndSeconds, realtime, timescale, externalClock } = this.state
    const { classes, type } = this.props;

    console.log("startDialogType: ", this.props.type);

    let start;
    let stop;
    start = 
    <Grid item xs={6}>
      <TextField 
        label="FMU Start Time"
        value={selectedStartSeconds}
        onChange={this.handleStartSecondChange}
        InputLabelProps={{shrink: true, className: this.props.classes.label}}
        disabled={realtime || externalClock}
        inputProps={{type: 'number', max: selectedEndSeconds}}
      />
    </Grid>;

    stop = 
    <Grid item xs={6}>
      <TextField 
        label="FMU Stop Time"
        value={selectedEndSeconds}
        onChange={this.handleEndSecondChange}
        InputLabelProps={{shrink: true, className: this.props.classes.label}}
        disabled={realtime || externalClock}
        inputProps={{type: 'number', min: selectedStartSeconds}}
      />
    </Grid>;

    return (
      <div>
        <Button className={classes.button} variant="contained" disabled={this.props.disabled} onClick={this.handleShowDialogClick}>Start Test</Button>
        <Dialog fullWidth={true} maxWidth='sm' open={this.state.open}>
          <DialogTitle>Simulation Parameters</DialogTitle>
          <DialogContent>
            <Grid container spacing={2}>
              {start}
              {stop}
              <Grid item xs={12}>
                <TextField 
                  label="Timescale"
                  value={this.state.timescale}
                  onChange={this.handleTimescaleChange}
                  InputLabelProps={{shrink: true, className: this.props.classes.label}}
                  disabled={realtime || externalClock}
                  inputProps={{type: 'number', min: 1, max: 200}}
                />
              </Grid>
              <Grid item xs={6}>
                <FormControlLabel
                  control={
                    <Switch
                      checked={realtime}
                      disabled={externalClock}
                      onChange={(event, checked) => this.setState({ realtime: checked })}
                    />
                  }
                  label="Realtime Simulation"
                />
              </Grid>
              <Grid item xs={6}>
                <FormControlLabel
                  control={
                    <Switch
                      checked={externalClock}
                      disabled={realtime}
                      onChange={(event, checked) => this.setState({ externalClock: checked })}
                    />
                  }
                  label="External Clock"
                />
              </Grid>
            </Grid>
          </DialogContent>
          <DialogActions>
            <Button onClick={this.handleRequestClose} color="primary">
              Cancel
            </Button>
            <Button onClick={this.handleRequestStart} color="primary">
              Run
            </Button>
          </DialogActions>
        </Dialog>
      </div>
    );
  }
}

export default withStyles(styles)(StartDialog);

