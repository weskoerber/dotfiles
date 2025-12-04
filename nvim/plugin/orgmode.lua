local orgmode = require('orgmode')

orgmode.setup({
    org_agenda_files = '~/Documents/org/**/*',
    org_default_notes_file = '~/Documents/org/refile.org',
    org_capture_templates = {
        m = {
            description = 'Meeting',
            template = '* Meeting with %? :MEETING:\n %t\n\n',
            target = '~/Documents/org/meetings.org',
            datetree = { reversed = true },
        },
        t = { description = 'Task', template = '* TODO %?\n %u' },
        s = {
            description = 'Scrum',
            template = '* Scrum :MEETING:\n %t\n\n%?',
            target = '~/Documents/org/scrum.org',
            datetree = { reversed = true },
        },
    },
    org_todo_keywords = {
        'TODO', 'NEXT', 'WAIT', 'HOLD', 'IDEA', '|',
        'DONE', 'DELE', 'NOTE', 'STOP',
    },
})
