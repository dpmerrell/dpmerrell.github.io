---
title: "Random Idea Generator" 
layout: note
tags: [research, computer-science, machine-learning, math]
---

Click `generate` for some fresh (mostly nonsense) project ideas: 

<button type="button"
onclick="document.getElementById('ideas').innerHTML = generateNIdeas(50);">generate</button>

<p id="ideas"></p>

<script>

function readJson () {
   // http://localhost:8080
   fetch("https://dpmerrell.github.io/assets/misc/idea_pieces.json")
   .then(response => {
       if (!response.ok) {
           throw new Error("HTTP error " + response.status);
       }
       return response.json();
   })
   .then(json => {
       this.ideadata = json;
       //console.log(this.ideadata);
   })
   .catch(function () {
       this.dataError = true;
   })

   return ideadata;
}

var ideadata = readJson();

function generateIdea() {
  var nounLen = ideadata.nouns.length;
  var adjectiveLen = ideadata.adjectives.length;
  var connectorLen = ideadata.connectors.length; 

  var adj1idx = Math.floor(Math.random() * adjectiveLen);
  var noun1idx = Math.floor(Math.random() * nounLen);
  var connectoridx = Math.floor(Math.random() * connectorLen);
  var adj2idx = Math.floor(Math.random() * adjectiveLen);
  var noun2idx = Math.floor(Math.random() * nounLen);

  var ideaStr = ideadata.adjectives[adj1idx] + " ";
  ideaStr += ideadata.nouns[noun1idx] + " ";
  ideaStr += ideadata.connectors[connectoridx] + " ";
  ideaStr += ideadata.adjectives[adj2idx] + " ";
  ideaStr += ideadata.nouns[noun2idx];

  var linkStr = "https://scholar.google.com/scholar?hl=en&as_sdt=0%2C50&q=";
  linkStr += ideadata.adjectives[adj1idx] + "+";
  linkStr += ideadata.nouns[noun1idx] + "+";
  linkStr += ideadata.connectors[connectoridx] + "+";
  linkStr += ideadata.adjectives[adj2idx] + "+";
  linkStr += ideadata.nouns[noun2idx];

  return "<a href='"+linkStr+"'>"+ideaStr+"</a>";
}

function generateNIdeas(N) {

    var ideas = "";
    for (let i = 0; i < N; i++) {
        ideas += "<br>" + generateIdea() + "<br>";
    }
    return ideas;
}

</script>


