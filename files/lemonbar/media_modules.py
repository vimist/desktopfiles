import subprocess as sp

import lemonbar_manager


PADDING = '   '  # Padding


class MediaControls(lemonbar_manager.Module):
    def __init__(self):
        super().__init__()

        self.status_map = {
            'Playing': f'%{{A:media_pause:}}{PADDING}\uF3E4{PADDING}%{{A}}',
            'Paused': f'%{{A:media_play:}}{PADDING}\uF40A{PADDING}%{{A}}',
            'Stopped': f'%{{A:media_play:}}{PADDING}\uf40A{PADDING}%{{A}}'
        }

        self.readables = [
            sp.Popen(
                ['playerctl', '-F', 'status'],
                stdout=sp.PIPE, bufsize=0).stdout
        ]

    def output(self):
        if not self.select():
            return self.cache if self.cache else ''

        status = self.readables[0].readline().decode('utf-8').strip()

        if status:
            return ''.join([
                #f'%{{A:media_prev:}}{PADDING}\uf4ae%{{A}}',
                self.status_map.get(status, ''),
                #f'%{{A:media_next:}}\uf4ad{PADDING}%{{A}}',
            ])
        else:
            return ''

    def handle_event(self, event):
        if event == 'media_play' or event == 'media_pause':
            sp.Popen(['playerctl', 'play-pause'])
        elif event == 'media_next':
            sp.Popen(['playerctl', 'next'])
        elif event == 'media_prev':
            sp.Popen(['playerctl', 'previous'])

