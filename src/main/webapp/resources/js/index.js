$("#btnCount").click(function () {
    let phrase = $("#txtWords").val();

if (isPhraseValid(phrase)) {
    let phraseCorrected = replaceAllowedPunctuation(phrase);
    showResult(phraseCorrected);
}

});

function showResult(phase) {
    $("#pResult").text("You've typed " + countWords(phase) + " words!");
}

function isPhraseValid(phase) {
    return isTheTextValid(phase);
}

function replaceAllowedPunctuation(phrase) {
    return phrase.replaceAll(",", "")
        .replaceAll(".", "")
            .replaceAll(";", "")
                .replaceAll("!", "")
                    .replaceAll("?", "")
                        .replaceAll(":", "")
                            .replaceAll("'", "")
                                .replaceAll("(", "")
                                    .replaceAll(")", "");
}

function countWords(phrase) {
    return phrase.trim().split(/\s+/).length;
}
function isTheTextValid(phrase) {
    if(isTextAreaBlack(phrase)){
        $("#pResult").text("You need to enter something first.")
        return false;
    }

    if(isAnyOfTheWordsNumbers(phrase)){
        $("#pResult").text("We do not understand numbers as words!")
        return false;
    }

    if(isAnyOfTheWordsSpecialChars(phrase)){
        $("#pResult").text("We do not understand these special characters as words: `@#$%^&*_+\\-=\\[\\]{};:\"\\\\|<>\\/~")
        return false;
    }

    return true;
}

function isTextAreaBlack(phrase){
    return phrase === null || phrase === '' || phrase === "" || phrase === 'undefined';
}

function isAnyOfTheWordsNumbers(phrase){
    return /\d/.test(phrase);
}

function isAnyOfTheWordsSpecialChars(phrase){
    let specialCharsNotAllowed = /[`#$%^&*_+\-=\[\]{}"\\|<>\/~]/;
    return specialCharsNotAllowed.test(phrase);
}