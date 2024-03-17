In formal verification, "system properties" refer to **precise statements about the desired behavior of a system** that are expressed in a **rigorous, mathematical language**. These properties serve as the target against which the system is evaluated for correctness, ensuring it aligns with its intended purpose and avoids unexpected or harmful behavior.

Several types of system properties exist, each focusing on different aspects of the system:

**Functional properties:**
* Describe the **expected outputs** of the system for given inputs, ensuring it delivers the correct results according to its specifications.
* Example: "For any non-empty input string, the length of the processed output string is always one less than the input."

**Safety properties:**
* Guarantees the system **operates within safe boundaries**, preventing critical failures or security vulnerabilities.
* Example: "The system never crashes due to memory overflow."

**Liveness properties:**
* Assure the system makes **progress towards its objectives** and avoids deadlock or livelock situations.
* Example: "The system eventually responds to every user request within a defined timeframe."

**Security properties:**
* Verify the system's **resistance to unauthorized access, data breaches, and malicious attacks**.
* Example: "Only authorized users can access confidential information."

**Performance properties:**
* Specify the system's **expected speed, throughput, and resource utilization**.
* Example: "The system processes at least 100 transactions per second under peak load."

**Reliability properties:**
* Capture the system's **ability to function correctly despite errors or unexpected conditions**.
* Example: "The system continues to operate smoothly even if one server fails."

Formal verification tools help analyze systems against these properties using various techniques like **model checking** and **theorem proving**. By ensuring system properties hold true, formal verification builds confidence in the system's correctness and reliability, especially for critical applications in domains like hardware design, software development, and security-sensitive systems.

