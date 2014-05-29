jQuery(function ($) {
    var prUrlTemplate = 'https://api.github.com/repos/{repoName}/pulls';

    $('#repo-name').on('change', function () {
        var repoName = $(this).val();
        $.getJSON(prUrlTemplate.replace('{repoName}', repoName)).done(function (data) {
            data.forEach(function (pullRequest) {
                var $html = $('<div/>');
                $html.text(pullRequest.number + ': ' + pullRequest.title);
                $('#results').append($html);
            });
        });
    });
});
