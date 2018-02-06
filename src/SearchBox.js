import React from 'react';
//import axios from 'axios'; //ajax library
//import { LibPath } from './LibPath';
import Autosuggest from 'react-autosuggest'; //  https://github.com/moroshko/react-autosuggest
import './css/SearchBox.css';
import StaffData from './StaffData';

export default class SearchBox extends React.Component {
  constructor() {
    super();

    this.state = {
      value: '',  //what has been typed into box
      suggestions: [],  //array of people objects that match query
    };  
    this.getSuggestionValue = this.getSuggestionValue.bind(this);
    this.onSuggestionSelected = this.onSuggestionSelected.bind(this);
    this.onKeyDown = this.onKeyDown.bind(this);
  }

  onChange = (event, { newValue, method }) => { 
    this.setState({
      value: newValue
    });
  };

  onSuggestionsFetchRequested = ({ value }) => {
    this.getSuggestions(value);
  };

  onSuggestionsClearRequested = () => {
    this.setState({
      suggestions: []
    });
  };

  //Employee is selected, pass data back up
  onSuggestionSelected=(event, { suggestion, suggestionValue, suggestionIndex, sectionIndex, method })=>{ 
    event.stopPropagation();
    this.props.handleSel(suggestion);
  }
  
  //if enter is pressed without a selection, send search term back up
  onKeyDown = (event) => { 
    if(event.key === 'Enter'){
     this.props.handleSel({SearchTerm:this.state.value});
    }
  };
 
 
  ///////////////////////////////////////////////////////////////////////
  getSuggestions(value) {  
    const self=this;
    const inputLength = value.length;
    if(inputLength <= 1){
      return []; 
    }else{
      let SelStaff = StaffData.filter(aStaff=>{
        return aStaff.Name.includes(value); //(/value/i).test(aStaff.Name); //  
      })
      self.setState({
        suggestions: SelStaff
      });
    }
  }

  getSuggestionValue( suggestion) { //when selected
    return suggestion.Name;
  }

  renderSuggestion(suggestion){
    const picstyle = suggestion.FileName?{backgroundImage: "url(./" + suggestion.FileName + ")"}:{};
    picstyle.backgroundColor = suggestion.IsCarePartners==="0" ? "#EEEEEF" : "white"; 
    return (
      <div style={picstyle} className="pic">
        <div className="name">
          {suggestion.Name}          
        </div>
        <div className="jobtitle">
          {suggestion.JobTitle}
        </div>
      </div>
    )
  };
  
  renderSuggestionsContainer = ({ containerProps, children, query }) => (
    <div {...containerProps}>
      {children}
      {
        <div className="footer">
          Press Enter to view all <strong>{query}</strong>
        </div>
      }
    </div>
  );  
  ///////////////////////////////////////////////////////////////////////
  
  render() { 
    const { value, suggestions } = this.state;
    const inputProps = {
      placeholder: "Search",
      value,
      onChange: this.onChange,
      onKeyDown: this.onKeyDown,
      autoFocus: "autoFocus"
    };

    return (
      <div className="outerdiv">
		  <Autosuggest 
			suggestions={suggestions}
			onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
			onSuggestionsClearRequested={this.onSuggestionsClearRequested}
			onSuggestionSelected={this.onSuggestionSelected}
			getSuggestionValue={this.getSuggestionValue}
			renderSuggestion={this.renderSuggestion}
			renderSuggestionsContainer={this.renderSuggestionsContainer}
			inputProps={inputProps} />
      </div>
    );
  }
}
