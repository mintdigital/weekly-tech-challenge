package validator

import "testing"

func TestIsStringNice(t *testing.T) {
	actual := IsStringNice("aaa")
	expected := true

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("ugknbfddgicrmopn")
	expected = true

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("jchzalrnumimnmhp")
	expected = false

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("haegwjzuvuyypxyu")
	expected = false

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}

	actual = IsStringNice("dvszwmarrgswjxmb")
	expected = false

	if actual != expected {
		t.Errorf("IsStringNice test expected [%t], actual [%t]", expected, actual)
	}
}

func benchmarkIsStringNice(str string, b *testing.B) {
	for n := 0; n < b.N; n++ {
		IsStringNice(str)
	}
}

func BenchmarkIsStringNice1(b *testing.B) { benchmarkIsStringNice("aaa", b) }
func BenchmarkIsStringNice2(b *testing.B) { benchmarkIsStringNice("ugknbfddgicrmopn", b) }
func BenchmarkIsStringNice3(b *testing.B) { benchmarkIsStringNice("jchzalrnumimnmhp", b) }
func BenchmarkIsStringNice4(b *testing.B) { benchmarkIsStringNice("haegwjzuvuyypxyu", b) }
func BenchmarkIsStringNice5(b *testing.B) { benchmarkIsStringNice("dvszwmarrgswjxmb", b) }
