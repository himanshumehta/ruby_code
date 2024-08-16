CUPID stands for Clarity, Uniqueness, Performance, Insight, and Depth.

Functional requirement 
- The system must be able to generate reports.	
- The system must be able to send email notifications.	
- The system must be able to process credit card payments.	

Non-functional requirement
- The system must be scalable to support 10,000 users.
- The system must be available 99.99% of the time.
- The system must be secure and protect user data.

# System Design

1. Requirement clarification
- Functional requirements
- Non-functional requirements
- Extended requirements - Analytics, Telemetry, Regionalization

2. Capacity estimation and constraints 
- Storage estimates
- Bandwidth estimation 
- Memory estimates

3. Database schema

4. System interface definition - ex postTweet, generateTimeline etc
- Discuss key logic - Like generating shortened url etc

5. Scale requirements
- Data base partioning and replcation

6. High level design
- Detailed design - Dig deeper into 2-3 components from high-level requirements

7. Identifying and resolving bottlenecks
8. Security and Permissions

### Capacity estimation and constraints 
For URL shortening
500M new url, 100:1 read:write, 50B redirection
100 * 500M => 50B

QPS(Queries per second)
500M/30 days * 24 hours * 3600 seconds ~= 200 url/second

URL redirection per second
100 * 200 = 200 k/second

### Bandwidth estimation and constraints
For write request, Since 200 url/second, total incoming bandwidth estimate
200 * 500 bytes = 100 kb/seconds

For read request
20k * 500 bytes = 10 MB/second

### Memory estimation and constraints
20K * 3600 seconds * 24 hours = 1.7 billion

To cache 20% of these requests
.2 * 1.7 billion * 500 bytes = 170 Gb

High level estimates: Assuming 500 million new URLs per month and 100:1 read:write ratio, following is the summary of the high level estimates for our service:
New URLs                200/s
URL redirections        20k/second
Incoming data           100Kb/second
Outgoing data           10MB/second
Storage for 5 years     15TB
Memory for cache        170Gb


- Load Balancer: Distributes incoming traffic across multiple servers to ensure efficient utilization and prevent overload.
- Edge Servers: Deployed in various geographical locations to reduce latency and improve the user experience.
- API Gateway: Manages the API endpoint traffic, provides security, and handles request load balancing.
- Authentication and Authorization Service: Ensures secure access control and authentication for users and services.
- Message Queuing Service: Handles asynchronous communication and ensures reliable delivery of messages between components.
- Media Storage Service: Stores multimedia content, such as images, videos, and audio files, for quick and reliable access.
- Real-time Communication Service: Facilitates voice and video communication between users in real-time.
- Global Network Infrastructure: Provides a robust and distributed network to support high availability across multiple geographical regions.
- Database Clustering: Enables data replication and distribution across multiple database servers for high availability and scalability.
- Caching Service: Speeds up data retrieval by storing frequently accessed data in a cache to reduce database load.
- Monitoring and Logging Service: Monitors system health, performance, and logs to identify issues and ensure smooth operations.
- Content Delivery Network (CDN): Optimizes content delivery by caching data at edge locations closer to the end-users.

### 2nd level
- Firewall and Security Infrastructure: Protects the system from unauthorized access and cyber threats.
- Identity Management System: Manages user identities, authentication, and permissions across the platform.
- Microservices Architecture: Organizes the system into smaller, independent services to enable scalability and agility.
- Scalable Storage Solution: Provides scalable and high-performance storage for handling large volumes of data.
- Service Discovery: Facilitates automatic detection and configuration of services in a dynamic environment.
- Disaster Recovery and Backup Systems: Implements plans and systems for data backup and disaster recovery to ensure data safety and availability.
- Auto-Scaling and Orchestration Service: Automatically adjusts resource allocation based on demand to maintain optimal performance and cost-efficiency.
- Compliance and Regulation Management: Ensures adherence to industry-specific regulations and compliance standards.
- Business Intelligence and Analytics: Gathers and analyzes data to provide valuable insights for business decision-making and optimization.
- Payment Processing Integration: Facilitates secure and seamless payment transactions within the platform.
- User Behavior Analytics: Monitors and analyzes user behaviour patterns to improve service offerings and user experience.
- API Documentation and Developer Portal: Provides comprehensive documentation and resources for developers to integrate and use the platform's services.

## Load Balancer

* Pros:
    * Efficiently distributes traffic, preventing server overloading.
    * Increases system reliability and availability.
    * Provides scalability for handling increased traffic.
    * Reduces latency by directing users to the closest available server.
    * Provides health checks to ensure that servers are available and performing properly.
* Cons:
    * Single point of failure if not configured properly.
    * Can introduce latency if not appropriately balanced.
    * Requires additional configuration and maintenance.

## Edge Servers

* Pros:
    * Reduces latency and improves user experience by serving content from servers closer to the user.
    * Enables faster content delivery through caching.
    * Provides resilience in the face of regional outages.
    * Offloads traffic from origin servers, improving performance and scalability.
* Cons:
    * Increased infrastructure and maintenance costs.
    * Data synchronization challenges between edge servers.
    * Complex management and deployment in multiple regions.

## API Gateway

* Pros:
    * Enhances security through centralized API management.
    * Provides request load balancing for improved performance.
    * Simplifies API development and deployment by providing a single entry point for clients.
    * Offers features such as authentication, authorization, throttling, and caching.
* Cons:
    * Can introduce a single point of failure.
    * Potential performance bottleneck if not optimized.
    * Requires careful configuration to prevent security vulnerabilities.

## Authentication and Authorization Service

* Pros:
    * Ensures secure access control for users and services by verifying identities and authorizing access to resources.
    * Facilitates a single sign-on experience for users.
    * Provides fine-grained access control for resources, allowing granular permissions to be assigned to users and groups.
* Cons:
    * Introduces additional complexity in the authentication flow.
    * Requires careful management of user credentials and permissions.
    * Can lead to performance overhead during authentication processes.

## Message Queuing Service

* Pros:
    * Enables asynchronous communication between components, decoupling them from each other and improving scalability and reliability.
    * Ensures reliable delivery of messages, even during system failures by storing messages in a queue until they can be processed.
    * Provides scalability for handling large message volumes by queuing messages and processing them in batches.
* Cons:
    * Potential message order issues in complex workflows, especially if messages are processed out of order.
    * Increased system complexity and potential points of failure, as the message queue itself can become a bottleneck or fail.
    * Requires careful monitoring to prevent message queue overflows.

## Media Storage Service

* Pros:
    * Allows quick and reliable access to multimedia content by storing it in a highly available and scalable storage system.
    * Provides scalability for handling large volumes of data by using a distributed storage architecture.
    * Enables efficient content delivery and streaming by providing low-latency access to content.
* Cons:
    * High storage costs for large volumes of multimedia content.
    * Potential data consistency and synchronization challenges, especially if the media storage service is used to store data that is frequently updated.
    * Requires careful management of data backups and disaster recovery to protect against data loss and corruption.

## Real-time Communication Service

* Pros:
    * Facilitates seamless voice and video communication in real time by providing a low-latency infrastructure for transmitting and receiving data.
    * Improves user engagement and experience by enabling real-time communication and collaboration.
    * Provides features such as video conferencing, audio calls, and chat.
* Cons:
    * Requires high bandwidth and network resources to support real-time communication.
    * Potential performance issues in low-quality network conditions, such as dropped packets and high latency.
    * Complex implementation and management for scalability and reliability, as the real-time communication service must be able to handle large numbers of concurrent users and sessions.

## Database Architecture

The database architecture should utilize a distributed design, distributing data across multiple servers for enhanced scalability, performance, and fault tolerance.

Two common approaches for a distributed database architecture are:

- Sharding: Divides data into subsets stored on separate servers for horizontal scaling.
- Master-slave Replication: Utilizes a primary master server for data storage, periodically updating slave servers.

## Database Servers

- **NoSQL databases** handle large data volumes with various data models like key-value pairs, document stores, graph databases, and wide-column stores.
- **SQL databases** store structured data, using a table-based model and SQL as a standard query language.

### Considerations for Choosing Between NoSQL and SQL Databases

- Data Model: Choose SQL for structured data and NoSQL for unstructured or semi-structured data.
- Scalability: NoSQL is generally more scalable due to relaxed data consistency.
- Performance: NoSQL excels in handling large data sets and complex aggregations.
- Cost: NoSQL is often cost-effective as it is open-source and requires less support.

## Storage

- **Solid state drives (SSDs)**
- **Network-attached storage (NAS)**
- **Object storage**

## Networking

- **Ethernet**
- **InfiniBand**
- **Fibre Channel**

## Monitoring and Management

- **Nagios**
- **Zabbix**
- **Ganglia**

## Geo Availability

To achieve geo availability, the database cluster can be replicated across multiple data centers in different geographic regions. Two common approaches include:

- Master-slave Replication: Each data center has a primary master server updating multiple slave servers.
- Multi-master Replication: Several master servers across different data centers regularly update one another.


# Tradeoffs:
## Tradeoffs between Performance and Scalability

**Performance:** The speed at which a system responds to requests.

**Scalability:** The ability of a system to handle an increasing workload.

Tradeoffs:

- Caching can boost performance but might reduce scalability due to increased memory usage and contention.
- Sharding enhances performance by distributing data across multiple servers but can complicate data querying, impacting scalability.

## Tradeoffs between Consistency and Availability

**Consistency:** The up-to-dateness of data in the system.

**Availability:** The uptime of a system.

Tradeoffs:

- Strong consistency ensures all nodes see the same data but might reduce availability by complicating data updates.
- Eventual consistency allows eventual synchronization but can lead to data inconsistencies, potentially affecting some applications.

## Conclusion

Balancing the tradeoffs between performance and scalability, as well as between consistency and availability, is critical in designing and implementing distributed systems. Striking the right balance is essential for specific system requirements.

## Example

- **Performance and Scalability:** A web application can improve performance through data caching, but this might hinder scalability due to increased memory usage and contention.

- **Consistency and Availability:** A distributed financial database can prioritize strong consistency for data accuracy, yet this may limit availability, making data updates more challenging.

In both cases, designers must carefully weigh the tradeoffs to meet the specific needs of the system.

# Designing an Async System for Concurrent Requests
Considerations:
1. **Decoupling:** Employ message queues, pub/sub systems, or actors to enable independent, non-blocking system components.
2. **Scalability:** Utilize sharding, load balancing, and caching to handle increasing workloads without performance degradation.
3. **Availability:** Ensure redundancy and failover mechanisms to sustain system operation during failures.

## High-level System Design
1. **Request Dispatcher:** Receives and distributes incoming requests to worker processes.
2. **Worker Processes:** Handle incoming requests and generate responses.
3. **Response Dispatcher:** Collects and sends responses back to clients.

The request and response dispatchers can be implemented using message queues or pub/sub systems. Worker processes can be threads, actors, or a combination.
To enhance scalability, shard worker processes across multiple servers. To improve availability, replicate dispatchers and worker processes across multiple servers.

Additional Considerations:
- Use load balancers for even request distribution among workers.
- Employ caching for frequently accessed data to reduce database queries.
- Implement asynchronous I/O to prevent worker process blocking.
- Monitor the system, identify bottlenecks, and take necessary actions such as workload sharding or adding servers.

# Database Cluster Overview

- **Description:** A database cluster consists of multiple database instances designed to manage high read and write requirements.
- **Techniques Used:**
  - Sharding: Horizontal partitioning of a large database into smaller, manageable shards stored on separate servers.
  - Replication: Creation and maintenance of data copies across multiple servers for enhanced availability, performance, and scalability.

## In-depth Considerations

### Sharding
- **Types:**
  - Horizontal Sharding: Divides the database by data range, facilitating optimized performance and horizontal scalability.
  - Vertical Sharding: Divides the database by data type, enabling efficient management of specific data subsets.

### Replication
- **Types:**
  - Synchronous Replication: Immediate data write to all replicas ensuring real-time data synchronization; impacts performance due to the necessity of all replicas being available.
  - Asynchronous Replication: Delayed data write to replicas, improving performance, but introduces data latency; uses message queues or replication logs for asynchronous data transfer.

### Database Cluster Considerations

- **Data Volume and Complexity:** Determines the number of shards required and the replication type.
- **Performance Requirements:** Influences the hardware and software requirements for the database cluster.
- **Availability Requirements:** Dictates the type and number of replicas needed for deployment.

# Conclusion
Database clusters, employing sharding for horizontal scaling and replication for data redundancy, are effective solutions for managing high read and write demands, ensuring performance, scalability, and availability for complex applications.

# Challenges and Considerations for Managing Resources with Multiple Workers on a Database  
## Challenges

1. **Deadlocks:** Occur when multiple workers are waiting for each other to release resources, leading to blocked processes and system stagnation.
2. **Resource Contention:** Arises when multiple workers attempt to access the same resources concurrently, potentially resulting in performance issues and data corruption.
3. **Consistency:** Ensuring data consistency becomes challenging when multiple workers concurrently update the same records, risking data loss or inconsistencies.
4. **Scalability:** Scaling a database to handle a substantial number of concurrent workers can be difficult without compromising performance and data consistency.

## Considerations

1. **Concurrency control in DBMS:** Opt for a DBMS with robust concurrency control features to mitigate deadlocks and concurrency issues.
2. **Database partitioning:** Improve performance and scalability by distributing workload across multiple servers through database partitioning.
3. **Caching layer implementation:** Reduce database load by storing frequently accessed data in a caching layer.
4. **Load balancer usage:** Employ a load balancer to evenly distribute traffic across multiple database servers.
5. **Regular database monitoring:** Continuously monitor the database to detect performance issues and potential concurrency problems.

## Additional Tips

- **Transactions:** Utilize transactions to maintain database consistency during concurrent data updates.
- **Caution with locks:** Use locks judiciously to prevent deadlocks and other concurrency-related challenges.
- **Optimistic locking:** Implement optimistic locking to minimize the risk of deadlocks during data updates.
- **Database connection pools:** Utilize database connection pools to enhance performance by managing the number of open and closed connections.
## Preventing Lost Updates and Dirty Reads

Concurrency control in a DBMS prevents lost updates and dirty reads through techniques like transaction isolation levels:

- **Read Committed Isolation Level:** Prevents transactions from reading uncommitted data.
- **Serializable Isolation Level:** Executes transactions as if in a serial order, preventing lost updates and dirty reads.

## Deadlock Prevention

Deadlocks, a common concurrency issue, occur when multiple workers are waiting for each other to release resources. To prevent deadlocks, DBMS utilize various techniques:

- **Locking:** Allows exclusive access to resources until the lock is released.
- **Timestamping:** Assigns unique timestamps to transactions, resolving conflicts based on timestamps.
- **Optimistic Locking:** Enables reading and updating data without acquiring a lock, aborting conflicting transactions if necessary.

## Optimistic Locking vs Pessimistic Locking

**Optimistic locking** enables concurrent reading and modification of data and checks for conflicts during the commit phase. It involves the use of a version column, where a transaction reads a row, modifies it, and updates the version number. When committing, the DBMS checks for version changes, aborting conflicting transactions if found. It is suitable for low-conflict scenarios, allowing high concurrency and improved performance.

**Pessimistic locking** prevents simultaneous data modifications by acquiring locks at various levels (row, table, or database) during the modification process. Other transactions are barred from modifying the data until the lock is released. It is suited for high-conflict scenarios, ensuring data integrity at the expense of reduced concurrency and performance.

## Database Connection Pools

A **database connection pool** comprises available database connections for application use. By reducing the need for frequent opening and closing of database connections, connection pools enhance performance and scalability, as these operations can be resource-intensive. Applications can simply request a connection from the pool, streamlining database access and improving overall application performance.

## Two-Phase Locking

**Two-phase locking** is a concurrency control protocol used to prevent deadlocks in a database. It requires transactions to acquire all necessary locks before any data modifications. Once acquired, these locks cannot be released until the transaction either commits or aborts. 

By implementing these best practices, effective and efficient resource management with multiple workers on a database can be achieved.

# Asynchronous I/O for Non-blocking Worker Processes

Asynchronous I/O is a programming technique that enables applications to execute I/O operations without obstructing the main thread of execution, thereby enhancing performance and responsiveness.

## Implementation Examples

1. **Callback Functions:** Functions passed as parameters to I/O operations, enabling the application to process other requests while the I/O operation executes.
2. **Events:** Facilitate communication between different parts of an application, triggering event handlers upon the completion of I/O operations.
3. **Asynchronous Programming Interfaces (APIs):** Offer callback functions or events for notifying the application when I/O operations are complete.

## Benefits of Asynchronous I/O

- **Improved Responsiveness:** Prevents the main thread of execution from being blocked, leading to applications that are more responsive to user input.
- **Increased Scalability:** Allows applications to handle a greater number of concurrent requests, as the main thread remains unblocked by I/O operations, enabling the processing of new requests.

# Redundancy and Failover Mechanisms Overview
## Common Examples

- **Redundant hardware:** Multiple copies of critical hardware components for seamless system operation.
- **Software redundancy:** Duplicate critical software components to ensure uninterrupted service.
- **N+1 redundancy:** Additional redundant components beyond the minimum operational requirement for added protection against multiple failures.
- **Failover clustering:** Software grouping of servers with automated failover for continuous service availability.
- **Geographic redundancy:** Distribution of redundant components across different geographic locations for protection against regional outages.

## Considerations for Redundancy and Failover Mechanisms

- **Criticality of the system:** Directly impacts the need for robust redundancy and failover strategies.
- **Cost of downtime:** Varies according to system type, with critical systems incurring higher costs during downtime.
- **Complexity of the system:** Influences the complexity and expense of implementing redundancy and failover mechanisms.

## Real-world Examples of Async Systems

1. **Email:** Queues help manage email delivery, ensuring a large volume of messages doesn't overwhelm servers.
2. **Social Media:** Queue-based delivery manages feed updates, preventing server overload during high traffic.
3. **Online Shopping:** Queues enable efficient order processing, preventing system overload during peak times.
4. **Financial Trading:** Queue-based execution ensures efficient trade processing during high market activity.
5. **Gaming:** Async systems manage game state updates, preventing server overload during gameplay.

Async systems are pervasive, from managing email and social media to online shopping and financial trading.

## Benefits of Async Systems in Real-world Systems

- **Performance:** Decoupling components enhances system performance.
- **Scalability:** Handling large volumes of requests becomes more manageable.
- **Availability:** Resilience to failures ensures continuous system operation.

# Interview Preparation Notes for L5 Interview

## Introduction
- Key points about system design, architecture, and scalability.
- Overview of cloud services and their role in modern computing.

## Container Orchestrator
- Definition and role of a container orchestrator in managing containerized applications.
- Key features and functionalities of container orchestrators.

## What is ECS?
- Explanation of ECS (Elastic Container Service) and its role in managing Docker containers.
- Key capabilities and benefits of ECS in container management.

## Fargate
- Overview of AWS Fargate and its significance in serverless container deployment.
- Understanding Fargate's role in managing containerized workloads without the need to provision and manage servers.

## What is EKS?
- Description of EKS (Elastic Kubernetes Service) and its importance in managing Kubernetes clusters.
- Exploring EKS's capabilities for deploying, managing, and scaling containerized applications using Kubernetes.
- Control plane processes in EKS: 
  - etcd
  - kube-apiserver
  - kube-controller-manager
  - kube-scheduler

## Worker Nodes
- Explanation of worker nodes and their role in distributed computing environments.
- Understanding how worker nodes handle containerized workloads and execute tasks.
- Sample services on worker nodes: 
  - NGINX
  - Redis
  - MySQL
- Worker processes in EKS:
  - kubelet
  - kube-proxy
  - Container runtime

## Difference Between EKS and ECS
- Comparative analysis of EKS and ECS based on their architecture, capabilities, and use cases.
- Highlighting the key distinctions between the two container orchestration services.

## Conclusion
- Summary of the key points discussed regarding container orchestrators, ECS, Fargate, EKS, control plane processes, worker nodes, and their roles in modern cloud computing.
- Reflection on the significance of choosing the appropriate container orchestration service based on specific application requirements and use cases.


# Actors, Queues and Pub/Sub 
Actors are concurrent entities that communicate via message passing, with each having its own state and behavior. They ensure isolation, addressability, and loose coupling. This model facilitates the development of scalable, fault-tolerant systems by enabling independent, asynchronous processing.

Message Queues:

- A message queue is a system that allows messages to be sent and received between applications. Messages are stored in a queue until they are processed by a consumer.
- Benefits:
  - Decoupling: Message queues decouple sender and receiver applications, allowing them to communicate asynchronously.
  - Scalability: Message queues can be scaled to handle a large volume of messages.
  - Reliability: Message queues can provide reliable message delivery, even in the event of failures.
- Drawbacks:
  - Complexity: Message queues can be complex to design and implement.
  - Performance: Message queues can add latency to message delivery.

Pub/Sub Systems:

- A pub/sub system is a system that allows messages to be published to one or more subscribers. Subscribers can receive messages that match their subscriptions.
- Benefits:
  - Decoupling: Pub/sub systems decouple publisher and subscriber applications, allowing them to communicate asynchronously.
  - Scalability: Pub/sub systems can scale to handle a large volume of messages.
  - Flexibility: Pub/sub systems are flexible and can be used to implement a variety of messaging patterns.
- Drawbacks:
  - Complexity: Pub/sub systems can be complex to design and implement.
  - Overhead: Pub/sub systems can add overhead to message delivery.

Actor Model:

- The actor model is a programming model that uses actors to represent concurrent entities. Actors communicate by sending messages to each other.
- Benefits:
  - Scalability: The actor model is scalable and can be used to implement highly concurrent systems.
  - Isolation: Actors are isolated from each other, which makes it easier to reason about and debug concurrent systems.
  - Modularity: Actors are modular and can be reused in different systems.
- Drawbacks:
  - Complexity: The actor model can be complex to understand and implement.
  - Performance: The actor model can add overhead to message delivery.

## Using a DLQ as a backup queue

A Dead Letter Queue (DLQ) in Amazon Simple Queue Service (Amazon SQS) is a queue that stores messages that cannot be processed by a consumer.
* DLQs are automatically created and managed by Amazon SQS.
* DLQs are highly durable and scalable.
* DLQs can be used to store messages for an extended period of time.
* DLQs can be used to implement a variety of queue-based workflows, such as retrying failed messages or storing messages for auditing purposes.

## When to use a DLQ:

When you need to retry failed messages automatically.
When you need to investigate why messages are failing to be processed.
When you need to audit messages that have been processed.

## When to use a backup queue:
When you need to protect against data loss.
When you need to enable backup and recovery.
When you need to simplify message archiving and compliance.

## Using DTOs for performance and scalability

DTOs can help to improve the performance and scalability of Golang applications by:

* Reducing the amount of data that needs to be transferred between different parts of the application.
* Reducing the amount of data that needs to be serialized and deserialized.
* Making the application more modular and easier to maintain.

## Best practices for using DTOs

Here are some best practices for using DTOs in Golang applications:
* Use struct tags to map DTO fields to database columns.
* Use validation to ensure that DTOs are valid before they are used.
* Use error handling to handle any errors that occur when using DTOs.
* Document the DTOs that you use.

# Database Cluster Design Considerations
When designing a database cluster, there are a number of factors to consider, including:

* Availability: The cluster should be designed to be highly available, with minimal downtime. This can be achieved by using a redundant architecture, such as a master-slave or multi-master replication setup.
* Scalability: The cluster should be able to scale to meet the demands of the application. This can be achieved by using a distributed architecture, where the database is spread across multiple servers.
* Performance: The cluster should be designed to perform well, with low latency and high throughput. This can be achieved by using a variety of techniques, such as caching and load balancing.
* Security: The cluster should be designed to be secure, with appropriate measures in place to protect the data. This can be achieved by using encryption, firewalls, and other security measures.
* Cost: The cost of the cluster should be considered when making design decisions. There are a number of ways to reduce the cost of a cluster, such as using open source software and cloud-based services.

# AWS ARN stands for Amazon Resource Name. 

It is a unique identifier for AWS resources, such as Amazon EC2 instances, Amazon S3 buckets, and Amazon RDS databases. ARNs are used to specify resources in AWS APIs and to grant access to resources using IAM policies.
An ARN has the following format:
* arn:{partition}:{service}:{region}:{account-id}:{resource-type}/{resource-id}
* partition: The AWS partition where the resource is located. For example, aws or aws-cn.
* service: The AWS service that the resource belongs to. For example, ec2, s3, or rds.
* region: The AWS region where the resource is located. For example, us-east-1 or eu-west-1.
* account-id: The AWS account ID that the resource belongs to.
* resource-type: The type of AWS resource. For example, instance, bucket, or database.
* resource-id: The unique identifier for the specific resource. For example, the instance ID of an Amazon EC2 instance or the bucket name of an Amazon S3 bucket.

