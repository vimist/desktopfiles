import subprocess as sp

import lemonbar_manager


class Count(lemonbar_manager.Module):
    def __init__(self, filter_string):
        """Count the number of 

        Parameters:
            filter_string (str): The filter string to pass to `task`.
        """
        super().__init__()
        self.wait_time = 60  # How often to update this module

        self._filter_string = filter_string

    def output(self):
        count = sp.run(
            ['task', self._filter_string, 'count'],
            capture_output=True, encoding='UTF-8').stdout.strip()

        return '\uF279 {}'.format(count)
