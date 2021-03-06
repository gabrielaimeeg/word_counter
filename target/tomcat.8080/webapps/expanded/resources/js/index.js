
$("#btnCount").click(function () {
    let phase = $("#txtWords").val();

if (isTheTextValid(phase)) {
    phase = replaceAllowedPunctuation(phase);
    $("#pResult").text("You've typed " + countWords(phase) + " words!")
}

});

function isTheTextValid(phase) {
    if(isTextAreaBlack(phase)){
        $("#pResult").text("You need to enter something first.")
        return false;
    }

    if(isAnyOfTheWordsNumbers(phase)){
        $("#pResult").text("We do not understand numbers as words!")
        return false;
    }

    if(isAnyOfTheWordsSpecialChars(phase)){
        $("#pResult").text("We do not understand these special characters as words: `@#$%^&*_+\\-=\\[\\]{};:\"\\\\|<>\\/~")
        return false;
    }

    return true;
}

function isTextAreaBlack(phase){
    return phase === null || phase ==='' || phase === 'undefined';
}

function isAnyOfTheWordsNumbers(phase){
    return /\d/.test(phase);
}

function isAnyOfTheWordsSpecialChars(phase){
    let specialCharsNotAllowed = /[`#$%^&*_+\-=\[\]{}"\\|<>\/~]/;
    return specialCharsNotAllowed.test(phase);
}

function replaceAllowedPunctuation(phase) {
    return phase.replaceAll(",", "")
        .replaceAll(".", "")
            .replaceAll(";", "")
                .replaceAll("!", "")
                    .replaceAll("?", "")
                        .replaceAll(":", "")
                            .replaceAll("'", "")
                                .replaceAll("(", "")
                                    .replaceAll(")", "");
}

function countWords(str) {
    return str.trim().split(/\s+/).length;
}