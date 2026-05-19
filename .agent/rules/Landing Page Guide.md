---
trigger: model_decision
description: when creating landing pages
---

# Landing Page Setup Guide

> **Purpose**: This document provides a step-by-step checklist for building a new landing page from scratch using our standard template. 

---

## Overview

When setting up your new landing page, you will need to configure several key areas:

1. **Brand Identity** - App name, logo, taglines
2. **Content & Copy** - Headlines, descriptions, features, FAQs
3. **Visual Assets** - Logo images, favicon, color scheme
4. **Configuration** - Package metadata
5. **Legal Pages** - Privacy policy, terms of service
6. **Contact Information** - Email addresses, social handles

---

## Pre-Setup Checklist

Before diving in, gather the following essentials:

- App name
- One-line description or tagline
- Core value proposition (what problem does it solve?)
- Primary brand color
- App logo/icon file (PNG recommended - save to your public directory), we are going to use the same logo for the app and the website, so when you generate it save it also to the asset folder so when we are building the app we can use it there too., then do not try to use terminal commad to create the app, use in your built in agentic image gen tool
- Support email address
- Social media handles
- Feature list (3-6 main features)
- How it works (typically 3 sequential steps)
- FAQ content (5-7 common questions and answers)

---

## Step-by-Step Setup Instructions

### Phase 1: Basic Configuration

1. **Package Settings (landing_page/package.json)**
   Update the project name to match your new application.

2. **Global Documentation (landing_page/README.md)**
   Set the title and write a clear overview of your application's purpose.

### Phase 2: Metadata and SEO

1. **Main Layout (landing_page/app/layout.tsx)**
   Set your page title and meta description. This is what shows up in search engine results and browser tabs.

### Phase 3: Navigation & Footer Branding

1. **Navigation Bar (landing_page/components/layout/Navbar.tsx)**
   Update the brand name text and the logo image or letter mark.

2. **Footer (landing_page/components/landing/Footer.tsx)**
   Update the logo, brand name, short description, and copyright year. Adjust the tagline to match your app.

### Phase 4: Core Landing Page Content

1. **Hero Section (landing_page/components/landing/Hero.tsx)**
   This is the first thing users see. Update the main headline to reflect your core value. Change the sub-description, badge text, and the main Call-To-Action (CTA) button text.

2. **Features Section (landing_page/components/landing/Features.tsx)**
   Update the section headline. Provide your actual app features, including a title, short description, and suitable icon for each.

3. **How It Works Section (landing_page/components/landing/HowItWorks.tsx)**
   Detail your user workflow. Provide clear, simple steps explaining how your application functions.

4. **FAQ Section (landing_page/components/landing/FAQ.tsx)**
   List your frequently asked questions and their comprehensive answers.

### Phase 5: General Pages

1. **Home Page Bottom CTA (landing_page/app/page.tsx)**
   Update the final call-to-action section at the bottom of the main page to encourage users to sign up or learn more.

### Phase 6: Legal & Informational Pages

*(Note: Ensure your legal pages are long, detailed, and professional. Avoid basic bulleted lists.)*

1. **Privacy Policy (landing_page/app/privacy-policy/page.tsx)**
   Write a complete, professional privacy policy relevant to your application. Make sure to update the support email and "Last Updated" date.

2. **Terms of Service (landing_page/app/terms/page.tsx)**
   Write a complete terms of service document outlining user guidelines and responsibilities specific to your app.

3. **Help Center (landing_page/app/help/page.tsx)**
   Update any category descriptions to guide users to the right support resources.

4. **Contact Page (landing_page/app/contact/page.tsx)**
   Provide your support email and relevant social media links.

### Phase 7: App Mockup View

1. **App Screen Component (landing_page/components/mockup/AppScreen.tsx)**
   Update the interactive or static mockups with realistic placeholder data that reflects what your application actually does. Change the logo and app name in the mockup headers.

### Phase 8: Visual Assets

1. **Logo Generation**
   Generate a modern app icon. Ensure you save it in the landing_page/public folder so the site can reference it. Update all components that display a logo to point to this new image.

2. **Favicon**
   Create a small icon version of your logo to act as the site's favicon. Place this in the landing_page/public directory.

### Phase 9: Color Scheme

1. **Theme Colors**
   If you want to move away from the default colors, search your project for the default color classes (like emerald or blue) and replace them with your brand's chosen color palette.

---

## Final Verification

Once you have completed the setup, run your development server and check the following:

- The site loads correctly without errors.
- All placeholder texts and old references are replaced.
- Logos and favicons are visible.
- CTAs are accurately linked.
- The color theme is consistent.
- Mobile responsiveness is maintained across sections.