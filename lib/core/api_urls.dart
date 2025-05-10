// ignore_for_file: constant_identifier_names

// const host = "http://192.168.0.14:3000/api/v1";
const host = 'https://business-management-2eaeeb9ab723.herokuapp.com/api/v1';

// Auth
const LOGIN_URL = "$host/login";
const REGISTRATION_URL = "$host/registration";

// Superadmin URLS
const ADD_BUSINESS_URL = "$host/superadmin/business";
const GET_ALL_BUSINESSES_URL = "$host/superadmin/businesses";
const ACCEPT_BUSINESS_URL = "$host/business-admin/accept-business";

// Business URLS
const EMPLOYEE_URL = "$host/business-admin/employee";
const EMPLOYEES_LIST_URL = "$host/business-admin/employees";
const EDIT_EMP_DETAILS_URL = "$host/business-admin/edit-employee";
const DELETE_EMP_URL = "$host/business-admin/delete-employee";
const EMPLOYEE_DETAILS_URL = "$host/business-admin/employee-details";

const ADD_EXPENSE_URL = "$host/business-admin/add-expense";
const EDIT_EXPENSE_URL = "$host/business-admin/edit-expense";
const DELETE_EXPENSE_URL = "$host/business-admin/delete-expense";
const EXPENSES_URL = "$host/business-admin/expenses";
const TRANSACTIONS_URL = "$host/business-admin/transactions";
const EXPENSES_BY_CHECKOUT_URL = "$host/business-admin/transactions/checkout";
const EMPLOYEE_EXPENSES_URL = "$host/business-admin/employee-expenses";

const FILTER_URL = "$host/business-admin/filter";

const TRANSACTION_CATEGORY_URL = "$host/business-admin/transaction-category";

const BUSINESS_PROFILE_URL = "$host/business-admin/profile";

const START_CHECKOUT_URL = "$host/business-admin/start-checkout";
const CLOSE_CHECKOUT_URL = "$host/business-admin/close-checkout";
const CHECKOUT_URL = "$host/business-admin/checkout";
const CHECKOUTS_URL = "$host/business-admin/checkouts";
const CLOSE_MONTHLY_CHECKOUT_URL = "$host/business-admin/close-month";

// Employee URLs
const EMP_EXPENSES_URL = "$host/employee/expenses";
const EMP_DETAILS_URL = "$host/employee";

// Notifications URL

const NOTIFICATIONS_URL = "$host/business-admin/notifications";
const READ_NOTIFICATIONS_URL = "$host/business-admin/read-notification";



