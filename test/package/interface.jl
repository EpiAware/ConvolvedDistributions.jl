# The abstract-family interface contract, verified with the shipped
# TestUtils verifiers (the same entry points a downstream member uses).

@testitem "AbstractConvolvedDistribution contract and membership" begin
    using Distributions
    using ConvolvedDistributions.TestUtils: test_abstract_membership,
        test_convolved_interface

    test_abstract_membership()

    test_convolved_interface(
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4));
        x = 3.0
    )
    test_convolved_interface(
        convolved(Normal(0.0, 1.0), Normal(1.0, 2.0));
        name = "Convolved (analytic)", x = 1.0
    )
    test_convolved_interface(
        difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4)); x = 0.5
    )
    test_convolved_interface(
        difference(Normal(1.0, 1.0), Normal(0.0, 1.0));
        name = "Difference (analytic)", x = 0.5
    )
    test_convolved_interface(
        product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4)); x = 4.0
    )
    test_convolved_interface(
        product(LogNormal(0.5, 0.4), LogNormal(0.0, 0.3));
        name = "Product (analytic)", x = 2.0
    )
    test_convolved_interface(
        ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4)); x = 1.0
    )
    test_convolved_interface(
        ratio(Normal(0.0, 1.0), Normal(0.0, 1.0));
        name = "Ratio (analytic)", x = 0.5
    )
    @test ConvolvedDistributions.Product <:
    ConvolvedDistributions.AbstractConvolvedDistribution
    @test ConvolvedDistributions.Ratio <:
    ConvolvedDistributions.AbstractConvolvedDistribution

    # Discrete instances of all three types (#85, #89): the contract
    # holds with an integer `x`.
    test_convolved_interface(
        convolved(Poisson(2.0), Poisson(3.0));
        name = "Convolved (discrete)", x = 4
    )
    test_convolved_interface(
        difference(Poisson(2.0), Poisson(3.0));
        name = "Difference (discrete)", x = 0
    )
    test_convolved_interface(
        product(Poisson(2.0), Poisson(3.0));
        name = "Product (discrete)", x = 4
    )
end

@testitem "TestUtils.test_discrete_pmf verifies discrete family members" begin
    using Distributions
    using ConvolvedDistributions.TestUtils: test_discrete_pmf

    test_discrete_pmf(
        convolved(NegativeBinomial(5, 0.5), Poisson(2.0));
        support = 0:60
    )
    test_discrete_pmf(
        difference(Poisson(2.0), Poisson(3.0)); support = -60:60
    )
    test_discrete_pmf(
        product(Poisson(2.0), Poisson(3.0)); support = 0:200
    )
end
