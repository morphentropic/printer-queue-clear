# Printer Queue Clear

This repository contains a simple batch script (`clear_print_spool.bat`) to clear a stuck Windows print queue.

## How it Works
The script follows a three-step process to clear the print queue:

#### 1. Stop the Print Spooler Service
The script first prompts the user for confirmation. If the user responds with "Y" (for yes), it uses `net stop spooler` to halt the Windows Print Spooler service. This is crucial because it releases the files currently being held in the print queue, allowing them to be deleted.

#### 2. Delete Queued Files
After the service is stopped, the script executes `del /Q /F /S %printers_path%`. This command deletes all files from the `%systemroot%\System32\Spool\Printers` folder. These files represent the documents currently waiting to be printed.

#### 3. Restart the Print Spooler Service
Finally, the script uses `net start spooler` to restart the Print Spooler service. This allows Windows to start accepting and processing new print jobs again. The script will also display a message confirming that all print queues have been cleared.

## Why This Solution is Common
When a print job gets stuck, it can't be deleted through the normal Windows interface. This is often because the Print Spooler service is "locked" onto the corrupted file. This script provides a reliable way to bypass this lock by first stopping the service, then manually clearing the queue's contents, and finally restarting the service to restore normal functionality. This method is widely used because it addresses the root cause of the problem directly.

![Printer Queue](https://raw.githubusercontent.com/morphentropic/printer-queue-clear/refs/heads/master/printer_queue.png)
