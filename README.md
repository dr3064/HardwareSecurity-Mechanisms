# Performance Overhead of OS and Hardware Security Mechanisms
Introduction
This project evaluates the performance overhead introduced by modern security mechanisms in the Linux kernel (version 6.6 LTS) and Node.js/V8 (version 20.x). Conducted within a Hyper-V virtual machine running Ubuntu 24.04 LTS, the study compares vanilla configurations (minimal security) against hardened configurations with selected security mechanisms. The objective is to quantify the computational and I/O overhead, identify the most impactful mitigations, and explore unexpected interactions between security features.

This report outlines the methodology, presents benchmark results based on provided values,
analyzes the performance impacts, and offers recommendations for balancing security and
performance in real-world deployments.
