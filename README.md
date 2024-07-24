# Payroll Period Manager

## Project Overview

This project involves creating a user interface and backend logic for a payroll period management system. The main goal is to enable payroll administrators to customize payroll period start and end dates while ensuring the following:

- Support for any payroll period as long as the end date is after the start date and there is no gap between the end of one period and the start of the next.
- A user-friendly interface for administrators to easily view and manage their custom payroll periods.
- The ability to query the current payroll period for any organization at any time.

This project was time-boxed to 10 hours but I did not require the full time to complete it.

<img alt="UI Screenshot" src="https://github.com/user-attachments/assets/74375780-bf87-4eb2-862e-1cf926ff0248"/>

## Features

### User Interface

- Administrators can create, edit, and delete payroll periods.
- The UI displays a list of all payroll periods for an organization.
- The UI displays a calendar with the current paydays highlighted.
- Sprinkled with hotwire/stimulus to make the UI more interactive (flash messages, dynamic / conditional rendering, etc).

### Backend Logic

- Payroll periods must have a start date, end date, and period type.
- Custom payroll periods must have a valid `custom_range`.
- Validation to ensure no gaps between consecutive payroll periods.
- Validation to prevent overlapping payroll periods.
- Ability to query and retrieve the current payroll period for any organization.

## Installation and Setup

### Prerequisites

- Ruby on Rails
- PostgreSQL

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/tgaeta/payroll_period_manager.git
   cd payroll_period_manager
   ```

2. Install the required gems:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:
   ```bash
   bin/dev
   ```
5. Run the tests:
   ```bash
   bin/rails test
   ```
