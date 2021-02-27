import subprocess as sp

import lemonbar_manager


class DiskUsage(lemonbar_manager.Module):
    def __init__(self, disk, update_interval=60):
        """Get the disk usage for a block device.

        Parameters:
            disk (str): The block device to get the usage of (i.e. /dev/sda1)
            update_interval (int): How often to update the module.
        """
        super().__init__()
        self.wait_time = update_interval

        self._disk = disk

    def output(self):
        process = sp.run(
            ['df', f'--output=avail,pcent', self._disk],
            capture_output=True, encoding='UTF-8')

        _, values = process.stdout.strip().split('\n')
        available, used = [int(v.strip('%')) for v in values.split(' ') if v]

        template = '\uF2CA {}G'

        if used > 90:
            template = (
                '%{{B#CF6A4C}} %{{F#111111}} '
                + template +
                ' %{{F-}}  %{{B-}}'
            )

        return template.format(round(available / 1024 / 1024, 1))

