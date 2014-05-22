jQuery(function ($) {
    var baseTitle = $('title').text() + ' for ';
    var prUrlTemplate = 'https://api.github.com/repos/{repoName}/pulls';
    var prTemplate = '<div><a href="{html_url}"><img src="{avatarUrl}" height="30" width="30">{number}: {title}</a> {daysAgo}</div>';
    var prFields = ['html_url', 'number', 'title', 'avatarUrl', 'daysAgo'];
    var avatarUrlTemplate = 'https://avatars.githubusercontent.com/u/{id}';
    var $prResults = $('#results');
    var msInADay = 60 * 60 * 24 * 1000;

    function setTitleForRepo(repoName) {
        $('title').text(baseTitle + repoName);
    }

    function displayPullRequests(repoName) {
        var url = prUrlTemplate.replace('{repoName}', repoName);
        $.getJSON(url, {sort: 'updated', direction: 'desc'}).always(function () {
            $prResults.empty();
        }).done(function (data, textStatus, jqXHR) {
            data.forEach(function (pullRequest) {
                var html = prTemplate;
                var lastUpdated = new Date(pullRequest.updated_at);
                var daysAgo = parseInt((new Date() - lastUpdated) / msInADay);
                pullRequest.avatarUrl = avatarUrlTemplate.replace('{id}', pullRequest.user.id);
                pullRequest.daysAgo = daysAgo > 0 ? daysAgo + ' days ago' : 'less than a day ago';
                prFields.forEach(function (field) {
                    html = html.replace('{' + field + '}', pullRequest[field]);
                });
                $prResults.append(html);
            });
        }).fail(function (jqXHR, textStatus, errorThrown) {
            $('#results').html('Error');
        });
    }

    function setHash(repoName) {
        location.hash = repoName;
    }

    $('#repo-name').on('change', function () {
        var repoName = $(this).val();
        setTitleForRepo(repoName);
        displayPullRequests(repoName);
        setHash(repoName);
    }).val(location.hash.slice(1)).trigger('change');

});
