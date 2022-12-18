---
layout: post
title:  "Thinking about startup stock options"
date:   2022-12-07 00:00:00 -0500
category: finance
tags: [finance, stock, options, startups, life-choices] 
---

I've been reading up on how equity compensation works at biotech startups.

Some of the more helpful sources I found:

* [Rapport](https://rapport.bio/all-stories/value-of-equity)
* [BioBuzz](https://biobuzz.io/before-you-accept-the-job-understand-the-basics-of-stock-options-and-long-term-incentives/)
* [Reddit](https://www.reddit.com/r/biotech/comments/m1mezy/startup_equity_offer_vs_number_of_employees_vs/)
* Wellfound/AngelList
    - [This blog post](https://angel.co/blog/9-terms-youll-see-in-your-equity-offer-and-what-they-actually-mean)
    - [This interactive tool](https://angel.co/salaries)
    - (I would guess Wellfound's numbers are more typical of software startups, which are much less capital-intensive than biotechs.)
* GPT-3:

![gpt-3 response]({{ site.baseurl }}/assets/images/equity-gpt3.jpg){:width="500px"} 


With enough reading I was able to arrive at coarse-grained mental model of the decision-landscape presented by equity compensation.

When I consider working for a startup, I expect to (a) take a somewhat lower salary than I would at a more mature company, in exchange for (b) exposure to potential upside contingent on the company's success.
The company will probably not succeed; but if it does, then I would hope it yields life-changing wealth.
I would also expect the risk and reward to be higher for employee 10 than for employee 100.

Suppose a startup offers 10,000 shares of stock options. Some things to think about:

$$ \text{your stake} = \frac{\text{your shares}}{\text{total shares outstanding}} $$

* What fraction of the company do those shares represent? Equivalently: what is the total number of shares outstanding?
* Is the total number of shares likely to increase? If the startup is very young then the answer is "yes&mdash;by a lot". If this is the case, then your fraction will shrink. This is called "dilution."
* This fraction of ownership (your "stake") gives an idea of the potential value of your shares. 
    - Suppose the 10,000 shares represent 0.1% of the startup. Then imagine all of your dreams come true, and the startup reaches a $1B valuation. 
    - In that case, your stake would be worth 0.001 x $1B = $1M. Which is great!
    - However, suppose there is significant dilution. Then the stake would be worth much less than that.
* Some other salient things to be aware of:
    - Vesting schedule. You will be given the stock options on a gradual basis. And this usually only begins to happen after you've been an employee for a whole year.
      The typical arrangement is "four year vesting with a one year cliff." This means you'll receive 0 options during the first year, and ~3,333 options the following three years (usually on a monthly basis). This schedule ends if you quit or get fired.
    - Liquidity. An early stage startup is usually a private company. It can be very difficult to sell the stock of a private company; you typically can't sell your stock until the company goes public or gets acquired (in which case the acquiring company may buy out your equity, though it's not guaranteed).
    - Strike price. It will cost money to exercise your options and get actual stock. For example, suppose we're back in the dream scenario and the strike price is $1 per share.
      Then you would have to pay $10K to obtain all of your stock (which you could then resell for $1M, netting $990K). The strike price can vary over the vesting schedule as the valuation of the company changes.
    - Taxes. You will have to pay taxes (a) when you exercise the options and (b) when you sell the stock. In the dream scenario, you will end up with much less than $990K post-tax.
    - If you quit or get fired, then you will be given a strict time limit to exercise your options&mdash;usually no more than 90 days. Otherwise you forfeit your options. This is a difficult situation if the shares are still illiquid! You either pay taxes and the strike price up front for illiquid stocks, waiting with the hope of a liquidity event in the future; or you throw away the options that you earned over years of employment. 

Once the offer is accepted, the value of the stock options is a random number that depends on (a) the startup's success; (b) your employment status in the startup and (b) certain choices you make.
It seemed natural to think of the situation as a [Markov decision process](https://en.wikipedia.org/wiki/Markov_decision_process).
I went through the trouble of sketching it out in Inkscape:

![title text]({{ site.baseurl }}/assets/images/equity-compensation-mdp.svg){:width="500px"} 

You begin at the top of the image. Time flows downward and out, roughly speaking. 
This doesn't show every possible state or action. My goal was to capture some of the more salient parts of the decision landscape.
Perhaps the most important part of this picture is the large probability of the company failing and the stock price going to zero.

I should emphasize that compensation is one of many criteria for taking a job.
The other criteria belong in different blog posts, though.

\\( \blacksquare\\)  

