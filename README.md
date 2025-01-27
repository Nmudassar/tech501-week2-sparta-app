
Here’s your content formatted as a **README.md** file, ready for use in VS Code:

```markdown
# Process Management

This documentation summarizes the key concepts, commands, and processes related to Linux process management. It covers topics such as process IDs, parent-child relationships, zombie processes, memory usage monitoring, and background job management.

---

## **1. Understanding Processes in Linux**

- A **process** is a program in execution. Each process has a unique **PID** (Process ID).

- Processes have a **parent-child hierarchy**:
  - A **parent process** spawns one or more **child processes**.
  - Child processes inherit certain properties from their parent.

### Commands to Explore Processes:

1. `ps`: View currently running processes.
   ```bash
   ps
   ```
   **Output Example**:
   ```
   PID   TTY          TIME CMD
   1713 pts/0    00:00:00 bash
   1767 pts/0    00:00:00 ps
   ```
   - **PID**: Process ID.
   - **TTY**: Terminal associated with the process.
   - **CMD**: Command that started the process.

2. `top`: Real-time view of system processes and resource usage.
   - **Sort by memory usage**: Press `Shift + M`.
   - **Sort by CPU usage**: Press `Shift + P`.

3. `jobs`: List background jobs started in the current shell.
   ```bash
   jobs
   ```
   - Shows job numbers but not PIDs.

4. `kill`: Terminate a process.
   - **Syntax**:
     ```bash
     kill <PID>
     ```
   - **Soft termination (graceful)**:
     ```bash
     kill -15 <PID>
     ```
   - **Force termination**:
     ```bash
     kill -9 <PID>
     ```

5. `killall`: Kill processes by name.
   ```bash
   killall <process_name>
   ```

6. `pgrep`: Find PIDs of processes by name.
   ```bash
   pgrep <process_name>
   ```

7. `$!`: Get the PID of the most recently started background process.
   ```bash
   sleep 500 &
   echo $!
   ```

---

## **2. Parent and Child Processes**

- When a parent process creates a child process, the parent process’s PID becomes the **PPID** (Parent Process ID) of the child.

- Use the `ps` command to see relationships:
  ```bash
  ps -o pid,ppid,cmd
  ```

### Key Points:

- A child process executes independently but reports its status back to the parent.
- The parent process can collect the child’s exit status using the `wait()` system call.

---

## **3. Zombie Processes**

### What is a Zombie Process?

- A **zombie process** is a process that has completed execution but remains in the process table because its parent process hasn’t read its exit status.

- **Characteristics**:
  - Status: `<defunct>` in `ps` or `top`.
  - Does not consume CPU or memory but uses a PID slot.

### Identifying Zombie Processes:

- Use the `ps` command:
  ```bash
  ps aux | grep 'Z'
  ```
- Check the status in `top` (marked as `Z`).

### Cleaning Zombie Processes:

1. Ensure the parent process calls `wait()` to reap the child process.
2. If the parent process is unresponsive, terminate it:
   ```bash
   kill <parent_pid>
   ```
   The zombie process will be adopted by `init` (PID 1), which will clean it up.
3. Reboot the system as a last resort.

### Avoiding Zombies:

- Ensure programs handle child processes properly using `wait()` or `waitpid()`.

---

## **4. Background Jobs and Process Management**

### Running Processes in the Background:

- Add `&` to the end of a command to run it in the background.
  ```bash
  sleep 500 &
  ```

### Viewing Background Jobs:

- Use `jobs` to see jobs started in the current shell.
  ```bash
  jobs
  ```
  **Output Example**:
  ```
  [1]+  Running    sleep 500 &
  ```

- To view the PID of a background job, use:
  ```bash
  jobs -l
  ```

### Bringing Background Jobs to Foreground:

- Use `fg` to bring a background job to the foreground.
  ```bash
  fg %1
  ```
  Here, `%1` refers to the job number.

### Stopping and Restarting Jobs:

- **Suspend a job** with `Ctrl + Z`.
- **Resume a job in the background**:
  ```bash
  bg %<job_number>
  ```

---

## **5. Monitoring and Managing System Resources**

### Memory and CPU Usage:

- Use `top` for real-time monitoring.
  - **Sort by memory**: Press `Shift + M`.
  - **Sort by CPU**: Press `Shift + P`.

### Example of Process Status:

```bash
ps -o pid,ppid,cmd,stat
```

- **STAT** column:
  - `R`: Running.
  - `S`: Sleeping.
  - `Z`: Zombie.
  - `T`: Stopped.

---

## **6. Signals in Process Management**

### Common Signals:

- **SIGTERM (15)**: Soft termination, allows cleanup.
  ```bash
  kill -15 <PID>
  ```
- **SIGKILL (9)**: Force termination, no cleanup.
  ```bash
  kill -9 <PID>
  ```
- **SIGSTOP**: Pause a process.
  ```bash
  kill -STOP <PID>
  ```
- **SIGCONT**: Resume a paused process.
  ```bash
  kill -CONT <PID>
  ```

---

This documentation provides a comprehensive guide to Linux process management. It covers everything from basic commands to handling complex scenarios like zombie processes. By mastering these concepts, you can effectively monitor and manage processes in a Linux environment.
```

Save this file as `README.md` in your project folder and open it in VS Code. You can preview the file by right-clicking it in the file explorer and selecting **"Open Preview"**. Let me know if you need further adjustments!