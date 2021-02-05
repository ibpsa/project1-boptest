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
import IconButton from '@material-ui/core/IconButton';
import {FileUpload} from '@material-ui/icons';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';
import Input from '@material-ui/core/Input';
import { InputLabel, InputLabelProps } from '@material-ui/core/Input';
import LinearProgress from '@material-ui/core/LinearProgress';
import 'normalize.css/normalize.css';
import styles from './Upload.scss';
import {cyan500, red500, greenA200} from '@material-ui/core/colors';
import { graphql } from 'react-apollo';
import gql from 'graphql-tag';
import { v1 as uuidv1 } from 'uuid';
import { withStyles } from '@material-ui/core/styles';

class FileInput extends React.Component {

  constructor(props) {
    super(props);
    this.fileInputRef = React.createRef();
    //this.onChange = this.onChange.bind(this);
    //this.onTextInputClick = this.onTextInputClick.bind(this);
    //this.render = this.render.bind(this);
    this.state = {
      filename: "",
      file: ""
    };
  };

  static propTypes = {
    hint: PropTypes.string,
    onFileChange: PropTypes.func,
  };

  handleFileChange = (evt) => {
    const file = evt.target.files[0];
    this.props.onFileChange(file);
    this.setState({filename: file.name, file: file});
  };

  handleTextInputClick = (evt) => {
    let el = this.fileInputRef.current;
    if (el.addEventListener) {
      el.addEventListener("change", this.handleFileChange, false);
    } else {
      el.attachEvent('onchange', this.handleFileChange);
    }
    el.click();
  };

  render = () => {
    return (
      <div>
        <input className={styles.hidden} type="file" ref={this.fileInputRef} onInput={this.handleFileChange} />
        <TextField fullWidth={true} label='Select Test Case' onClick={this.handleTextInputClick} value={this.state.filename}
          InputLabelProps={{
            shrink: this.state.filename != ""
          }}
        >
        </TextField>
      </div>
    )
  }
}

class Upload extends React.Component {

  constructor() {
    super();
    this.onModelFileChange = this.onModelFileChange.bind(this);
    this.onWeatherFileChange = this.onWeatherFileChange.bind(this);
    this.onClick = this.onClick.bind(this);

    this.state = {
      modelFile: null,
      weatherFile: null,
      uploadID: null,
      completed: 0
    };
  };

  static propTypes = {
    //className: PropTypes.string,
  };

  static contextTypes = {
    authenticated: PropTypes.bool,
    user: PropTypes.object
  };

  onModelFileChange(file) {
    this.setState({modelFile: file, completed: 0, uploadID: uuidv1()});
  }

  onWeatherFileChange(file) {
    this.setState({weatherFile: file, completed: 0});
  }

  onClick(onCompleteProp) {
    if( this.state.modelFile ) {
      const key = `uploads/${this.state.uploadID}/${this.state.modelFile.name}`;

      const request = new XMLHttpRequest();

      const uploadComplete = () => {
        onCompleteProp(this.state.modelFile.name, this.state.uploadID);
      };

      const uploadFailed = () => {
        console.log("There was an error attempting to upload the file." + evt);
      };

      const uploadCanceled = () => {
        console.log("The upload has been canceled by the user or the browser dropped the connection.");
      };

      const uploadProgress = (evt) => {
        if (evt.lengthComputable) {
          var percentComplete = Math.round(evt.loaded * 100 / evt.total);
          if (percentComplete > 100) {
            this.setState({completed: 100});
          } else {
            this.setState({completed: percentComplete});
          }
        }
        else {
          console.log('percent: unable to compute');
        }
      };

      const uploadFile = () => {
        const response = JSON.parse(request.responseText);

        if ( ! response ) {
          console.log('Failed to acquire upload url');
          return;
        }

        var xhr = new XMLHttpRequest();

        xhr.upload.addEventListener("progress", uploadProgress, false);
        xhr.addEventListener("load", uploadComplete, false);
        xhr.addEventListener("error", uploadFailed, false);
        xhr.addEventListener("abort", uploadCanceled, false);

        // TODO: Need to configure this on server side
        xhr.open('POST', response.url, true);

        let formData = new FormData();
        console.log(response)
        Object.entries(response.fields).forEach(([key, value]) => {
            formData.append(key, value);
        });
        formData.append('file', this.state.modelFile);

        xhr.send(formData);  // multipart/form-data
      };

      const url = '/upload-url';
      const params = JSON.stringify({ name: key });
      request.open('POST', url, true);
      request.setRequestHeader("Content-type", "application/json; charset=utf-8");
      request.addEventListener("load", uploadFile, false);
      request.send(params);
    } else {
      console.log('Select file to upload');
    }
  }

  modelFileHint() {
    if( this.state.modelFile ) {
      return this.state.modelFile.name;
    } else {
      return undefined;
    }
  }

  weatherFileHint() {
    if( this.state.weatherFile ) {
      return this.state.weatherFile.name;
    } else {
      return 'Select Weather File';
    }
  }

  render() {
    const { classes } = this.props;

    return (
      <div className={styles.root}>
        <LinearProgress variant="determinate" value={this.state.completed} />
        <div className={styles.center}>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <FileInput hint={this.modelFileHint()} onFileChange={this.onModelFileChange}/>
            </Grid>
            <Grid item xs>
              <Button fullWidth={true} variant="contained" color="primary" onClick={() => {this.onClick(this.props.addJobProp)} }>Upload Test Case</Button>
            </Grid>
          </Grid>
        </div>
      </div>
    );
  }
}

const localstyles = theme => ({
  button: {
    margin: theme.spacing(1),
  },
});

const withStyle = withStyles(localstyles)(Upload);

const addJobQL = gql`
  mutation addJobMutation($osmName: String!, $uploadID: String!) {
    addSite(osmName: $osmName, uploadID: $uploadID)
  }
`;

const runSimQL = gql`
  mutation runSimMutation($uploadFilename: String!, $uploadID: String!) {
    runSim(uploadFilename: $uploadFilename, uploadID: $uploadID)
  }
`;

const withRunSim = graphql(runSimQL, {
  props: ({ mutate }) => ({
    runSimProp: (uploadFilename, uploadID) => mutate({ variables: { uploadFilename, uploadID } }),
  }),
})(withStyle);

export default graphql(addJobQL, {
  props: ({ mutate }) => ({
    addJobProp: (osmName, uploadID) => mutate({ variables: { osmName, uploadID } }),
  }),
})(withRunSim);
