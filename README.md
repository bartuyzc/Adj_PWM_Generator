# Project Structure
## Top Level
In this top level design, we connect the debouncing filter to the inputs, however, I do not suggest to connect it for behavioral simulations. It affects the results non-accurately.
<img width="975" height="416" alt="image" src="https://github.com/user-attachments/assets/2ba6cc4d-8216-46d4-9e21-eb3493c6836d" />
## PWM Generator
Simulate this module for better and accurate results.

<img width="445" height="325" alt="image" src="https://github.com/user-attachments/assets/80624724-86a3-4545-aa72-39301c68155a" />

- `inc_duty` / `dec_duty`: Changes the duty time duration by changing `ACTIVE` register. Step size is 5%.
- `inc_freq` / `dec_freq`: Manages the changes with selecting period values from look-up-table. Step size is approximately 100 KHz.  
  (When we reach the higher frequencies, our sensitivity faces some scaling issues due to the fact that changes become roughly 100 KHz.)
- `mode_select`:  
  `0`: edge-aligned / `1`: center-aligned
- `rst`: The design uses a common reset signal for each module, which drives the outputs to `'0'`.
- `clk`: This one is also common for the system, and I’ve chosen 40 ns for the operating period.

## Debouncing Filter
You can also change the divisor parameter that included in clk_divider.v file.
<img width="489" height="223" alt="image" src="https://github.com/user-attachments/assets/0e927cbe-3047-40e1-8f7f-79646c1543c3" />
<img width="969" height="308" alt="image" src="https://github.com/user-attachments/assets/1581621f-ee43-4423-b587-9a2e91d177d9" />
# Simulation
<img width="1448" height="264" alt="image" src="https://github.com/user-attachments/assets/2fd29690-f102-4c00-b87b-b72aa975b64c" />
There are also more simulation results at the report.pdf. You can check it out.
