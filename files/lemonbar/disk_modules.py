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
            ['df', '-h', '-P', self._disk],
            capture_output=True, encoding='UTF-8')

        headers, values = process.stdout.strip().split('\n')

        headers = [h.strip().lower() for h in headers.split(' ') if h]
        values = [v for v in values.split(' ') if v]

        fields = {h: v for h, v in zip(headers, values)}

        return '\uF2CA {avail}'.format(**fields)
